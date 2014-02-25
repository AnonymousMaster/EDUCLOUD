class AddUnitPriceToPurchaseItem < ActiveRecord::Migration
  def self.up
   add_column :purchase_items, :unit_price, :decimal
  end

  def self.down
     remove_column :purchase_items, :unit_price
  end
end
