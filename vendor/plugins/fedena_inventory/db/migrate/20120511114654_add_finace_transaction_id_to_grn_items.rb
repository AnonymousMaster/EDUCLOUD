class AddFinaceTransactionIdToGrnItems < ActiveRecord::Migration
  def self.up
      add_column :grn_items , :finance_transaction_id ,:integer
     
  end
 
  def self.down
     remove_column :grn_items , :finance_transaction_id
  end
end
