class CreateGrnItems < ActiveRecord::Migration
  def self.up
    create_table :grn_items do |t|
      t.integer :grn_id
      t.integer :store_item_id
      t.integer :quantity
      t.integer :unit_price
      t.integer :tax
      t.date :expiry_date

      t.timestamps
    end
    
  end

  def self.down
    drop_table :grn_items
  end
end
