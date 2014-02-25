class PurchaseItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :store_item
  validates_presence_of :quantity, :discount, :tax
  validates_numericality_of  :quantity, :greater_than => 0, :less_than => 100000
  validates_numericality_of:discount,:tax, :greater_than_and_equal => 0, :less_than => 100

end

