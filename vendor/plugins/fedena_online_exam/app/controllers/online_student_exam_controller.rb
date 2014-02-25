class OnlineStudentExamController < ApplicationController

    before_filter :login_required#,:only_student_allowed,:online_exam_enabled
    filter_access_to :all
    def index
        @student = current_user.student_record
        @exams = @student.available_online_exams
        if request.post?
            @current_exam = OnlineExamGroup.find(params[:exam][:exam_id])
            render :update do |page|
                page.replace_html 'box', :partial=>'details'
            end
        end
    end

    def start_exam
        @student = current_user.student_record
        @exam = OnlineExamGroup.find(params[:id])

        unless @exam.already_attended(@student.id)
            @exam_attendance = OnlineExamAttendance.create(:online_exam_group_id=> @exam.id, :student_id=>@student.id, :start_time=>Time.now)
            @exam.online_exam_options.map {|op| @exam_attendance.online_exam_score_details.build(:online_exam_question_id=>op.online_exam_question_id, :online_exam_option_id=>op.id)}
        else
        render :partial => 'already_attended' and return
        end
        render :layout => false

    end

    def save_exam
        @exam_attendance = OnlineExamAttendance.find(params[:id])
        render :partial => 'late_submit' and return if @exam_attendance.start_time+@exam_attendance.online_exam_group.maximum_time.minutes+2.minutes < Time.now
        params[:online_exam_attendance][:online_exam_score_details_attributes].each_pair  do |k,v|
            unless v["_delete"] == "0"
                answer = OnlineExamScoreDetail.new(:online_exam_attendance_id=>params[:id] ,:online_exam_question_id=> v[:online_exam_question_id],:online_exam_option_id=>v[:online_exam_option_id])
                if OnlineExamOption.find(v[:online_exam_option_id]).is_answer
                    answer.is_correct = true
                else
                    answer.is_correct = false
                end
                answer.save
            end
        end
        @total_score = @exam_attendance.online_exam_group.online_exam_questions.sum('mark')
        score = @exam_attendance.student_score
        pass_mark = (@total_score*@exam_attendance.online_exam_group.pass_percentage.to_f)/100
        score >= pass_mark ? passed = true : passed = false
        if @exam_attendance.update_attributes(:total_score=>score, :is_passed=>passed, :end_time=>Time.now)
        flash.now[:notice]="#{t('you_have_successfully_completed_the_exam')}"
        end
        render :layout => false and return
    end


end
