class OnlineExamOption < ActiveRecord::Base
 belongs_to :online_exam_question
 has_many :online_exam_score_details

    validates_presence_of :option

    xss_terminate :except => [ :option ]
end
