class ChangeDataTypeForStoreItemsUnitPrice < ActiveRecord::Migration
  def self.up
    change_table :store_items do |t|
      t.change :unit_price, :float
      t.change :tax, :float
   end
  end
  def self.down
       change_table :store_items do |t|
      t.change :unit_price, :integer
      t.change :tax, :integer
    end
  end
end
