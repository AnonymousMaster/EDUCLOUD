class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.integer :store_type_id
      t.integer :store_category_id
      t.string :name
      t.string :code

      t.timestamps
    end
   
  end

  def self.down
    drop_table :stores
  end
end
