class SupplierTypesController < ApplicationController
  # GET /supplier_types
  # GET /supplier_types.xml
  def index
    @supplier_type = SupplierType.new
    @supplier_types = SupplierType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @supplier_types }
    end
  end

  # GET /supplier_types/1
  # GET /supplier_types/1.xml
  def show
    @supplier_type = SupplierType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @supplier_type }
    end
  end

  # GET /supplier_types/new
  # GET /supplier_types/new.xml
  def new
    @supplier_type = SupplierType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @supplier_type }
    end
  end

  # GET /supplier_types/1/edit
  def edit
    @supplier_type = SupplierType.find(params[:id])
  end

  # POST /supplier_types
  # POST /supplier_types.xml
  def create
    @supplier_type = SupplierType.new(params[:supplier_type])

    respond_to do |format|
      if @supplier_type.save
        flash[:notice] = 'Supplier Type was successfully created.'
        format.html { redirect_to(supplier_types_path) }
        format.xml  { render :xml => @supplier_type, :status => :created, :location => @supplier_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @supplier_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /supplier_types/1
  # PUT /supplier_types/1.xml
  def update
    @supplier_type = SupplierType.find(params[:id])

    respond_to do |format|
      if @supplier_type.update_attributes(params[:supplier_type])
        flash[:notice] = 'Supplier Type was successfully updated.'
        format.html { redirect_to(supplier_types_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @supplier_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /supplier_types/1
  # DELETE /supplier_types/1.xml
  def destroy
    @supplier_type = SupplierType.find(params[:id])
    @supplier_type.destroy
   flash[:notice] = 'Supplier Type was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(supplier_types_url) }
      format.xml  { head :ok }
    end
  end
end
