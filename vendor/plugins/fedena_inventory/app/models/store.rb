class Store < ActiveRecord::Base
  has_many :store_items
  has_many :store_types
  has_many :store_categories
  has_many :indents
  has_many :purchase_orders
  validates_presence_of:name, :code, :store_type_id , :store_category_id
  validates_length_of     :name, :within => 1..20
  validates_uniqueness_of :code
  validates_length_of     :code, :within => 1..10

end

