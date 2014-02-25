class InstantFeeParticular < ActiveRecord::Base
  belongs_to :instant_fee_category
  validates_presence_of :name,:amount,:instant_fee_category_id
  validates_numericality_of :amount,:greater_than => 0
end
