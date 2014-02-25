class Supplier < ActiveRecord::Base
  has_many :purchase_orders
  belongs_to :supplier_type
  validates_presence_of:supplier_type_id, :name, :contact_no
  validates_format_of     :tin_no, :with => /^[A-Z0-9]*$/i
  validates_length_of :name, :in => 2..30
  validates_uniqueness_of:contact_no
  validates_numericality_of :contact_no, :allow_blank => true
#  validates_format_of :contact_no, :with => /^[1-9]\d{9}$/
end
