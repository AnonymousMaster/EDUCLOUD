class GrnItem < ActiveRecord::Base
   belongs_to :grn
   belongs_to :store_item
   validates_presence_of :quantity, :unit_price, :store_item_id
   validates_numericality_of  :quantity, :unit_price, :greater_than => 0, :less_than => 100000
   #has_one :finance_transaction,:as => :finance
end

