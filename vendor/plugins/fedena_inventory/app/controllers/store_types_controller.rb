class StoreTypesController < ApplicationController
  before_filter :login_required
  filter_access_to :all
  # GET /store_types
  # GET /store_types.xml
  def index
    @store_type = StoreType.new
    @store_types = StoreType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @store_types }
    end
  end

  # GET /store_types/1
  # GET /store_types/1.xml
  def show
    @store_type = StoreType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store_type }
    end
  end

  # GET /store_types/new
  # GET /store_types/new.xml
  def new
    @store_type = StoreType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store_type }
    end
  end

  # GET /store_types/1/edit
  def edit
    @store_type = StoreType.find(params[:id])
  end

  # POST /store_types
  # POST /store_types.xml
  def create
    @store_type = StoreType.new(params[:store_type])

    respond_to do |format|
      if @store_type.save
        flash[:notice] = 'Store Type was successfully created.'
        format.html { redirect_to(store_types_path) }
        format.xml  { render :xml => @store_type, :status => :created, :location => @store_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /store_types/1
  # PUT /store_types/1.xml
  def update
    @store_type = StoreType.find(params[:id])

    respond_to do |format|
      if @store_type.update_attributes(params[:store_type])
        flash[:notice] = 'Store Type was successfully updated.'
        format.html { redirect_to(store_types_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /store_types/1
  # DELETE /store_types/1.xml
  def destroy
    @store_type = StoreType.find(params[:id])
    @store_type.destroy
flash[:notice] = 'Store Type was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(store_types_url) }
      format.xml  { head :ok }
    end
  end
end

