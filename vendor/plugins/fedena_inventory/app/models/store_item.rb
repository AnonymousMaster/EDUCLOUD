class StoreItem < ActiveRecord::Base
  belongs_to :store
  has_many :indent_items
  has_many :purchase_items
  has_many :grn_items
  belongs_to :grn
  validates_presence_of :item_name
  validates_numericality_of  :quantity, :greater_than => 0, :less_than => 100000,:on => :create
  validates_numericality_of  :unit_price 
  validates_format_of :unit_price, :with => /^\d+??(?:\.\d{0,2})?$/
  validates_numericality_of :tax, :greater_than_and_equal => 0, :less_than => 100
  validates_presence_of :tax


end

