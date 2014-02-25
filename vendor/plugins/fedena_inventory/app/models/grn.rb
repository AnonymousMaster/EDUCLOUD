class Grn < ActiveRecord::Base

  belongs_to :supplier
  belongs_to :purchase_order
  belongs_to :store
  belongs_to :supplier_type
  has_many :store_items
  has_many :grn_items, :dependent => :destroy
  after_create :update_store
  accepts_nested_attributes_for :grn_items, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy => true
  validates_presence_of :grn_no,:invoice_no,:purchase_order_id,  :in=>1..6
  validates_presence_of :supplier_type_id,:supplier_id, :store_id
  validates_uniqueness_of :grn_no
  validates_associated :grn_items
  validates_format_of     :invoice_no, :with => /^[A-Z0-9_-]*$/i
  has_one :finance_transaction,:as => :finance
 # validates_numericality_of:other_chages, :greater_than_and_equal => 0, :less_than => 100

private

 def update_store
    inventory = FinanceTransactionCategory.find_by_name('Inventory')
      amount= 0
       self.grn_items.each do |i|
         i.store_item.update_attributes!(:quantity => (i.store_item.quantity + i.quantity), :unit_price =>i.unit_price)
         amount += ( i.quantity *  i.unit_price )+ ( i.quantity *  i.unit_price )* ( i.tax * 0.01)
       end
     amount += self.other_chages unless self.other_chages.nil?
    finance =   FinanceTransaction.create(:title =>"#{self.store.name}",:description => "#{inventory.description}",:finance_id=>self.id,:finance_type=>"Inventory",:receipt_no => self.invoice_no, :category_id =>  inventory.id,  :amount=> amount, :transaction_date=> Date.today  )
   self.update_attributes(:finance_transaction_id=> finance.id )
 end


end

