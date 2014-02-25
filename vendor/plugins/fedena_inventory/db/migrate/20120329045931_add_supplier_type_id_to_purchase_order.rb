class AddSupplierTypeIdToPurchaseOrder < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :supplier_type_id, :integer
   
  end
 
  def self.down
    remove_column :purchase_orders, :supplier_type_id
  end
end
