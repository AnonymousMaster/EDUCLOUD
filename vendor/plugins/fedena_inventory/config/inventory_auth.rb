authorization do


  #Inventory module
  role :inventory do
    has_permission_on [:stores],  :to => [:index, :edit, :destroy, :show, :new, :create, :update,:setting]
    has_permission_on [:store_types],  :to => [:index, :edit, :destroy, :show, :new, :create, :update]
    has_permission_on [:store_items],  :to => [:index, :edit, :destroy, :show, :new, :create, :update, :search_ajax]
    has_permission_on [:store_categories],  :to => [:index, :edit, :destroy, :show, :new, :create, :update]
    has_permission_on [:indents],  :to => [:index, :edit, :destroy, :show, :new, :create, :update, :acceptance, :search, :search_ajax, :update_item, :indent_pdf,:update_storeitem, :dynamic_items   ]
    has_permission_on [:purchase_orders],  :to => [:index, :edit, :destroy, :show, :new, :create, :update, :po_pdf,:update_supplier, :po_accept]
    has_permission_on [:grns],  :to => [:index, :edit, :destroy, :show, :new, :create, :update, :update_item,:grn_pdf,:update_supplier, :update_po, :report, :report_detail]
    has_permission_on [:suppliers],  :to => [:index, :edit, :destroy, :show, :new, :create, :update]
    has_permission_on [:supplier_types],  :to => [:index, :edit, :destroy, :show, :new, :create, :update]
    has_permission_on [:inventories],  :to => [:index]
    has_permission_on [:javascripts],  :to => [:dyanamic_items]
   end

  role :admin do
    includes :inventory
  end


   role :inventory_manager do
     has_permission_on [:indents],  :to => [:index, :edit, :destroy, :show, :new, :create, :update, :acceptance,:set_manager, :search, :search_ajax, :update_item, :indent_pdf,:update_storeitem, :dynamic_items   ]
     has_permission_on [:purchase_orders],  :to => [:index, :edit, :destroy, :show, :new, :create, :update,:po_pdf,:update_supplier, :po_accept]
     has_permission_on [:store_items],  :to => [:index, :edit, :destroy, :show, :new, :create, :update, :search_ajax]
     has_permission_on [:inventories],  :to => [:index]
     has_permission_on [:javascripts],  :to => [:dyanamic_items]

   end


  role :employee do
     has_permission_on [:indents],  :to => [:index, :edit, :destroy, :show, :new, :create, :update, :set_manager, :update_item, :indent_pdf,:update_storeitem, :dynamic_items   ]
     has_permission_on [:store_items],  :to => [:index,  :search_ajax]
     has_permission_on [:inventories],  :to => [:index]
     has_permission_on [:javascripts],  :to => [:dyanamic_items]

  end




end

