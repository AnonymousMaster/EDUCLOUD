class JavascriptsController < ApplicationController

  def dynamic_items
    @store_items = StoreItem.find(:all)
  end

end
