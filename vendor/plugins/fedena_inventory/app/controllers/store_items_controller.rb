class StoreItemsController < ApplicationController
  before_filter :login_required
  filter_access_to :all

  def index
   # @store_items = StoreItem.search(params[:search])
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @store_items }
      format.js
    end
  end

  def show
    @store_item = StoreItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store_item }
    end
  end

  def new
    @store_item = StoreItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store_item }
    end
  end

  def edit
    @store_item = StoreItem.find(params[:id])
  end

  def create
    @store_item = StoreItem.new(params[:store_item])

    respond_to do |format|
      if @store_item.save
        flash[:notice] = 'Store Item was successfully created.'
        format.html { redirect_to(store_items_path) }
        format.xml  { render :xml => @store_item, :status => :created, :location => @store_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @store_item = StoreItem.find(params[:id])
    respond_to do |format|
      if @store_item.update_attributes(params[:store_item])
        flash[:notice] = 'Store Item was successfully updated.'
        format.html { redirect_to(store_items_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @store_item = StoreItem.find(params[:id])
    @store_item.destroy
 flash[:notice] = 'Store Item was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(store_items_url) }
      format.xml  { head :ok }
    end
  end

  def search_ajax
      if params[:search_store] == 'All'
        @store_items = StoreItem.paginate(:all, :page => params[:page], :include=>:store,
          :conditions => ["item_name LIKE ? ", "#{params[:query]}%" ])       
       else
        #if params[:query].length>= 2
           @store_items = StoreItem.paginate(:all, :page => params[:page], :include=>:store,
          :conditions => ["stores.name LIKE ? and item_name LIKE ?  ", "#{params[:search_store]}%","#{params[:query]}%" ] )
     #end
     end
    render :partial => 'search_ajax'
  end
  
end

