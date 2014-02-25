class OnlineExamQuestion < ActiveRecord::Base
    has_many :online_exam_options , :dependent => :destroy
    has_many :online_exam_score_details
    belongs_to :online_exam_group
    validates_presence_of :question, :mark
    validates_associated :online_exam_options, :on=>:create
    accepts_nested_attributes_for :online_exam_options
    attr_accessor :option_count
    validates_numericality_of :mark, :less_than_or_equal_to=> 100,:greater_than=> 0

    before_create :min_one_answer
    xss_terminate :except => [ :question ]

    def min_one_answer
        flag = false
        self.online_exam_options.each do |v|
        flag = true if v.is_answer
        end
        if flag
        return true
        else
        errors.add_to_base"#{t('atleast_one_option_must_be_answer')}"
        return false
        end
    end

end
