class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :supplier_type
      t.string :name
      t.integer :contact_no
      t.text :address
      t.integer :tin_no
      t.string :region
      t.text :help_desk

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
