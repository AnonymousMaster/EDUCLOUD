class CreateStoreItems < ActiveRecord::Migration
  def self.up
    create_table :store_items do |t|
      t.integer :store_id
      t.string :item_name
      t.integer :quantity
      t.integer :unit_price
      t.integer :tax

      t.timestamps
    end
  end

  def self.down
    drop_table :store_items
  end
end
