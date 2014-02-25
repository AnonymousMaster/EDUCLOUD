class AddSchoolIdToInventory < ActiveRecord::Migration
  def self.up
    [:grn_items,:grns,:indent_items,:indents,:purchase_items,:purchase_orders,:store_categories,\
      :store_items,:stores,:store_types,:suppliers,:supplier_types].each do |c|
      add_column c,:school_id,:integer
      add_index c,:school_id
    end
  end
  def self.down
    [:grn_items,:grns,:indent_items,:indents,:purchase_items,:purchase_orders,:store_categories,\
      :store_items,:stores,:store_types,:suppliers,:supplier_types].each do |c|
      remove_index c,:school_id
      remove_column c,:school_id
    end
   end
end
