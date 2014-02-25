class AddIndexToInventory < ActiveRecord::Migration
  def self.up
     add_index :store_items, :store_id
     add_index :stores, :store_type_id
     add_index :stores, :store_category_id
     add_index :indents, :user_id
     add_index :indents, :store_id
     add_index :indents, :employee_department_id
     add_index :indent_items, :indent_id
     add_index :indent_items, :store_item_id
     add_index :purchase_orders, :store_id
     add_index :purchase_orders, :supplier_id
     add_index :purchase_items, :purchase_order_id
     add_index :purchase_items, :store_item_id
     add_index :purchase_items, :user_id
     add_index :purchase_orders, :indent_id
     add_index :grns, :supplier_id
     add_index :grns, :purchase_order_id
     add_index :grns, :store_id
     add_index :grn_items, :grn_id
     add_index :grn_items, :store_item_id
     add_index :suppliers, :supplier_type_id
     add_index :purchase_orders, :supplier_type_id
     add_index :grns, :supplier_type_id
   
  end

  def self.down
     remove_index :store_items, :store_id
     remove_index :stores, :store_type_id
     remove_index :stores, :store_category_id
     remove_index :indents, :user_id
     remove_index :indents, :store_id
     remove_index :indents, :employee_department_id
     remove_index :indent_items, :indent_id
     remove_index :indent_items, :store_item_id
     remove_index :purchase_orders, :store_id
     remove_index :purchase_orders, :supplier_id
     remove_index :purchase_items, :purchase_order_id
     remove_index :purchase_items, :store_item_id
     remove_index :purchase_items, :user_id
     remove_index :purchase_orders, :indent_id
     remove_index :grns, :supplier_id
     remove_index :grns, :purchase_order_id
     remove_index :grns, :store_id
     remove_index :grn_items, :grn_id
     remove_index :grn_items, :store_item_id
     remove_index :suppliers, :supplier_type_id
     remove_index :purchase_orders, :supplier_type_id
     remove_index :grns, :supplier_type_id
    
  end
end
