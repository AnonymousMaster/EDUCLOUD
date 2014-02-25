class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.string :po_no
      t.integer :store_id
      t.integer :supplier_id
      t.date :po_date
      t.string :reference

      t.timestamps
    end
    
  end

  def self.down
    drop_table :purchase_orders
  end
end
