class ChangeDataTypeForSupplierTin < ActiveRecord::Migration
  def self.up
      change_table :suppliers do |t|
      t.change :tin_no, :string
   end
  end
  def self.down
      change_table :suppliers do |t|
      t.change :tin_no, :integer
    end
   end
end
