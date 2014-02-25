class AddPoStatusToPurchaseOrder < ActiveRecord::Migration
  def self.up
 add_column :purchase_orders, :po_status, :string
  end

  def self.down
remove_column :purchase_orders, :po_status
  end
end

