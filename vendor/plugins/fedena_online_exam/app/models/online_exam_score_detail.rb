class OnlineExamScoreDetail < ActiveRecord::Base
    belongs_to :online_exam_attendance
    belongs_to :online_exam_question
    belongs_to :online_exam_option
end
