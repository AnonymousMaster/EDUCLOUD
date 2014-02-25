class OnlineExamGroup < ActiveRecord::Base
    has_many :online_exam_attendances
    has_many :online_exam_questions
    has_many :online_exam_options, :through=>:online_exam_questions
    has_many :online_exam_score_details, :through=>:online_exam_questions
    belongs_to :batch

    validates_presence_of :name, :start_date, :end_date, :maximum_time, :pass_percentage
    validates_numericality_of :pass_percentage, :less_than_or_equal_to=> 100,:greater_than_or_equal_to=> 0
    validates_numericality_of :maximum_time, :less_than_or_equal_to=> 100,:greater_than_or_equal_to=> 0

    cattr_reader :per_page
    @@per_page = 13
    


    def already_attended(student)
        OnlineExamAttendance.exists?( :student_id => student, :online_exam_group_id=>self.id)
    end

    def has_attendence
        if self.online_exam_attendances.blank?
            return false
        else
            return true
        end
    end

end
