class ChangeDataTypeUnitPriceTaxToDecimal < ActiveRecord::Migration
   def self.up
    change_table :store_items do |t|
      t.change :unit_price, :decimal
      t.change :tax, :decimal
   end
    change_table :indent_items do |t|
      t.change :price, :decimal
   end
    change_table :grns do |t|
      t.change :other_chages, :decimal
   end
    change_table :grn_items do |t|
      t.change :unit_price, :decimal
      t.change :tax, :decimal 
   end
  end
  
 def self.down
    change_table :store_items do |t|
      t.change :unit_price, :float
      t.change :tax, :float
    end
   change_table :indent_items do |t|
      t.change :price, :integer
   end
   change_table :grns do |t|
      t.change :other_chages, :integer
   end
   change_table :grn_items do |t|
      t.change :unit_price, :integer
      t.change :tax, :integer 
  end
 
 end

end
