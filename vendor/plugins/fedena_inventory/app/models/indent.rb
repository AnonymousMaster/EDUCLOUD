class Indent < ActiveRecord::Base
 # before_save :indende_status
  validates_presence_of :indent_no, :store_id, :manager_id,:user_id
  validates_uniqueness_of :indent_no
  belongs_to :employee
  belongs_to :user
  belongs_to :store
  belongs_to :employee_department
  has_many :purchase_orders
  has_many :indent_items, :class_name => 'Indent'
  has_many :indent_items, :dependent => :destroy
  accepts_nested_attributes_for :indent_items, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy => true
  belongs_to :manager, :class_name => "Employee", :foreign_key=> "manager_id"
  validates_length_of :indent_no, :in=>1..6
  


#private

#def indende_status
#self.status = "Pending"

#end



end

