class ChangeDataTypeForSupplierContactNo < ActiveRecord::Migration
  def self.up
     change_table :suppliers do |t|
      t.change :contact_no, :integer, :limit=> 8
   end
  end
  def self.down
  change_table :suppliers do |t|
      t.change :contact_no, :integer
  end
  end
end
