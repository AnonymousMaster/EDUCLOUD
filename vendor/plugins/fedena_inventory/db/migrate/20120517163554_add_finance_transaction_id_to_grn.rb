class AddFinanceTransactionIdToGrn < ActiveRecord::Migration
  def self.up
    remove_column :grn_items , :finance_transaction_id
    add_column :grns, :finance_transaction_id, :integer
    add_index :grns, :finance_transaction_id
  end


  def self.down
     add_column :grn_items , :finance_transaction_id, :integer
     remove_column:grns, :finance_transaction_id
  end

end

