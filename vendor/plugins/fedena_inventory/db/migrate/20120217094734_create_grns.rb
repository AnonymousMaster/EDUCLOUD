class CreateGrns < ActiveRecord::Migration
  def self.up
    create_table :grns do |t|
      t.string :grn_no
      t.integer :supplier_id
      t.integer :purchase_order_id
      t.integer :store_id
      t.string :invoice_no
      t.date :grn_date
      t.date :invoice_date
      t.integer :other_chages

      t.timestamps
    end
   
  end

  def self.down
    drop_table :grns
  end
end
