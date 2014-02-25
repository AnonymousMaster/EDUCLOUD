class AddIndentIdToPurchaseOrder < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :indent_id, :integer 
   
  end
   

  def self.down
    remove_column :purchase_orders, :indent_id
  end
end
