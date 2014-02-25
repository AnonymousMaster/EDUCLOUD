class OnlineExamAttendance < ActiveRecord::Base
    has_many :online_exam_score_details, :dependent => :destroy
    belongs_to :online_exam_group
    belongs_to :student

    validates_associated :online_exam_score_details
    accepts_nested_attributes_for :online_exam_score_details


    def student_score
        score = 0
        self.online_exam_group.online_exam_questions.each do |q|
            is_correct = true
            s = q.online_exam_score_details
            unless s.empty?
                s.each do |s|
                    is_correct = false unless s.is_correct
                end
                score += q.mark.to_f if is_correct
            else
                is_correct = false
            end
        end
        return score
    end
end
