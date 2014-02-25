ActionController::Routing::Routes.draw do |map|
  map.resources :grns
  map.resources :purchase_orders
  map.resources :supplier_types
  map.resources :suppliers
  map.resources :indents
  map.resources :indents, :collections => { :acceptance => :get }
  map.resources :stores, :collections  => {:setting=> :get}
  map.resources :purchase_orders, :collections => { :po_accept => :get }
  map.resources :stores do |store|
  store.resources :store_items
  end
  map.resources :store_categories
  map.resources :store_types
  map.resources :store_items

 map.feed 'inventories/settings',:controller => 'inventories' ,:action=>'index'
 map.indent_search 'search', :controller =>'indents', :action => 'search'
 map.grn_report 'report', :controller => 'grns' , :action => 'report'
 map.grn_report_detail 'report_detail', :controller => 'grns' , :action => 'report_detail'
 map.feed 'javascripts/dynamic_items.:format', :controller=> 'javascripts', :action =>'dynamic_items'
 map.indent_items 'dynamic_items', :controller =>'indents', :action => 'dynamic_items'
 
 end
