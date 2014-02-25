class SupplierType < ActiveRecord::Base
 validates_presence_of:name,:code
  has_many :suppliers
  has_many :purchase_orders
  has_many :grns

end