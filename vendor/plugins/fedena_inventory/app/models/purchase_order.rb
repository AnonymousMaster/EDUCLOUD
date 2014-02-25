class PurchaseOrder < ActiveRecord::Base
  before_create :purchase_order_status
  validates_uniqueness_of :po_no
  validates_presence_of :po_no
  validates_presence_of :store_id
  belongs_to :store
  belongs_to :supplier
  belongs_to :indent
  belongs_to :supplier_type
  has_many :grns
  has_many :purchase_items, :dependent => :destroy
  accepts_nested_attributes_for :purchase_items, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy => true



 private

def purchase_order_status
 self.po_status= "Pending"
end

end

