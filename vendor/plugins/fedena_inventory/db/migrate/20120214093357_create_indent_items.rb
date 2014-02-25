class CreateIndentItems < ActiveRecord::Migration
  def self.up
    create_table :indent_items do |t|
      t.integer :indent_id
      t.integer :store_item_id
      t.integer :quantity
      t.string :batch_no
      t.integer :pending
      t.integer :issued
      t.string :issued_type
      t.integer :price
      t.integer :required

      t.timestamps
    end
    
  end

  def self.down
    drop_table :indent_items
  end
end
