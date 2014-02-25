Privilege.find_or_create_by_name(:name => "InventoryManager", :description=>"inventory_manager_privilege")
Privilege.find_or_create_by_name(:name => "Inventory", :description=>"inventory_privilege")
FinanceTransactionCategory.find_or_create_by_name(:name=>"Inventory",:is_income=>false,:description=>"Inventory Module for Fedena")