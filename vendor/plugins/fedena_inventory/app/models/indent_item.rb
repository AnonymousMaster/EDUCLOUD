class IndentItem < ActiveRecord::Base
  belongs_to :store_item
  belongs_to :indent
 # validates_presence_of :indent
  validates_presence_of  :batch_no, :quantity, :issued, :issued_type, :store_item_id, :required, :price
  validates_numericality_of  :required, :price, :greater_than => 0, :less_than => 100000
  validates_numericality_of  :issued,  :greater_than_equal => 0, :less_than => 100000
  # validates_length_of :quantity, :issued, :batch_no, :required, :pending,:price
 # validates_length_of :issued_type
end

