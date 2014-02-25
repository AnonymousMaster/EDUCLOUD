class InstantFeeDetail < ActiveRecord::Base
  belongs_to :instant_fee
  belongs_to :instant_fee_particular

  def particular_name
    self.instant_fee_particular.nil? ? self.custom_particular : self.instant_fee_particular.name
  end

  def particular_description
    self.instant_fee_particular.nil? ? "Custom Particular" : self.instant_fee_particular.description
  end
end
