class AddSupplierTypeIdToGrn < ActiveRecord::Migration
  def self.up
    add_column :grns, :supplier_type_id, :integer
   
  end
 
  def self.down
    remove_column :grns, :supplier_type_id
  end
end
