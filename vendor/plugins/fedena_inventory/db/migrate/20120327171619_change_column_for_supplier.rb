class ChangeColumnForSupplier < ActiveRecord::Migration
  def self.up
   remove_column :suppliers, :supplier_type
   add_column :suppliers, :supplier_type_id, :integer
   
  end
  
  def self.down
   add_column :suppliers, :supplier_type, :string
   remove_column :suppliers, :supplier_type_id
  end
end

