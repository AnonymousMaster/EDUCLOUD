class CreatePurchaseItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_items do |t|
      t.integer :purchase_order_id
      t.integer :user_id
      t.integer :store_item_id
      t.integer :quantity
      t.integer :discount
      t.integer :tax

      t.timestamps
    end
    
  end

  def self.down
    drop_table :purchase_items
  end
end
