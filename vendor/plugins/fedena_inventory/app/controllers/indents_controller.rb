  class IndentsController < ApplicationController
  before_filter :login_required
  before_filter :set_manager
  filter_access_to :all

  def index  
    if @current_user.employee and not  @current_user.privileges.include?(Privilege.find_by_name('InventoryManager'))
       unless @reporting_manager.nil?
       @indents= Indent.paginate(:all,:page=>params[:page],:include=>[:manager,:user, :employee_department], :conditions => ["(indents.indent_no LIKE ? OR indents.status LIKE ? ) AND (indents.user_id = ? OR employees.user_id = ?)","#{params[:search]}%","#{params[:search]}%",@current_user.id,@current_user.id],:per_page => 30)
       end
     elsif  @current_user.privileges.include?(Privilege.find_by_name('InventoryManager')) || @current_user.admin?
       @indents = Indent.paginate(:all,:page=>params[:page],:include=>[:user, :manager,:employee_department], :conditions => ["(indents.indent_no LIKE ? OR indents.status LIKE ? )","#{params[:search]}%","#{params[:search]}%"],:per_page => 30)
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @indents }
     end
   end
  
  def show
    @indent = Indent.find(params[:id], :include=> :indent_items)
    @total = 0
    @indent.indent_items.each do |i|
      @total  += ( i.required *  i.price ) 
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @indent }
    end
  end

  def new
     @store_items=[]
    @indent = Indent.new
    @last_indent =Indent.last.indent_no unless Indent.last.nil?

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @indent }
    end
  end


  def edit
    @indent = get_indent(params[:id])
  end

  def create
    @indent = Indent.new(params[:indent])
    respond_to do |format|

      if @indent.save
        flash[:notice] = 'Indent was successfully created.'
        format.html { redirect_to(@indent) }
        format.xml  { render :xml => @indent, :status => :created, :location => @indent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @indent.errors, :status => :unprocessable_entity }

    	end
    end
  end
  

  def update
    @indent = get_indent(params[:id])

    respond_to do |format|
      if @indent.update_attributes(params[:indent])
        flash[:notice] = 'Indent was successfully updated.'

        format.html { redirect_to(@indent) }
        format.pdf { render :layout => false }
      else
        format.html { render :action => "edit" }

      end
    end
  end


  def destroy
    @indent = get_indent(params[:id])
    @indent.destroy
    flash[:notice] = 'Indent was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(indents_url) }
      format.xml  { head :ok }
    end
  end

  def acceptance
    @indent = Indent.find(params[:id], :include=> [:indent_items, {:indent_items => :store_item}, :store])
    purchase_order_no = PurchaseOrder.last
    notice=""
    unless @indent.indent_items.nil?
      if @indent.update_attributes(params[:indent])
        if @indent.status == "Accepted"
          @indent.indent_items.each do |i|
            if i.store_item.quantity >= i.required
              quantity = (i.store_item.quantity - i.required)
              i.store_item.update_attributes!(:quantity => quantity )
              notice <<  " #{ i.required } #{i.store_item.item_name}   Available and Issued . "
            else
              quantity = (i.store_item.quantity - i.required)         
              i.store_item.update_attributes!(:quantity => quantity )
              store_id = @indent.store_id          
              if  purchase_order_no.nil?
                po = @indent.purchase_orders.find_or_create_by_indent_id(:store_id => store_id, :po_no => "PO00"  )
                po.purchase_items.create!(:store_item_id => i.store_item_id, :quantity => (quantity).abs, :discount=> 0, :tax=>0 )
              else
                po = @indent.purchase_orders.find_or_create_by_indent_id(:store_id => store_id, :po_no =>  purchase_order_no.po_no.next  )
                po.purchase_items.create!(:store_item_id => i.store_item_id, :quantity => (quantity).abs, :discount=> 0,:unit_price => i.store_item.unit_price, :tax=> i.store_item.tax )
              end
               purchase_order_no = PurchaseOrder.last
              if i.store_item.quantity > 0
               notice <<  " Issued #{i.store_item.quantity }  #{i.store_item.item_name} , Purchase Order #{  purchase_order_no.po_no} raised for #{ (quantity).abs } #{i.store_item.item_name}.  "
              else
               notice <<  " Purchase Order #{  purchase_order_no.po_no} raised for #{ (quantity).abs } #{i.store_item.item_name}. "
             end
            end
            @indent.status = "Issued"
            @indent.save
          end
          flash[:notice] = notice
          redirect_to :controller => 'store_items', :action => 'index'
        elsif  @indent.status == "Rejected"
          @indent.indent_items.each do |i|
            i.store_item.update_attributes!(:quantity => ((i.store_item.quantity + i.required)))
            notice <<  " #{(i.store_item.quantity - i.required).abs} #{i.store_item.item_name}   Added to store   "
            po = @indent.purchase_orders.find_by_store_id( @indent.store_id)
            unless po.nil?
              po.destroy
            end
          end
          @indent.status = "cancelled"
          @indent.save
          redirect_to :controller => 'store_items', :action => 'index'
        elsif @indent.status == "Cancel"
          @indent.status = "cancel"
          @indent.save
          redirect_to :controller => 'indents', :action => 'index'
        end
        flash[:notice] = notice
      end
    end
  end

  def search

  end

  def search_ajax
    if params[:search_inventory]=="Indent"
      unless params[:query] == ''
        @indents = Indent.find(:all, :include=>[:manager, :user, :employee_department],
          :conditions => ["indent_no LIKE ?  OR status LIKE ? " ,"%#{params[:query]}%","%#{params[:query]}%"],
          :order => "indent_no asc" )
      else
        @indents = Indent.find(:all)
      end
      render :partial => 'indent_search'
    elsif params[:search_inventory]== "Purchase_order"
      unless params[:query] == ''
        @purchase_orders = PurchaseOrder.find(:all,:include=>[:store],
          :conditions => ["po_no LIKE ? ", "%#{params[:query]}%"],
          :order => "po_no asc" )
      else
        @purchase_orders = PurchaseOrder.find(:all)
      end
      render :partial => 'po_search'
    elsif params[:search_inventory]== "GRN"
      unless params[:query] == ''
        @grns = Grn.find(:all, :include=>[:purchase_order, :supplier,:supplier_type],
          :conditions => ["grn_no LIKE ? ", "%#{params[:query]}%"],
          :order => "grn_no asc" )
      else
        @grns = Grn.find(:all)
      end
      render :partial => 'grn_search'

    end
  end
  def dynamic_qty
    @store = StoreItem.all
  end

  def update_item
    @i =  params[:i]
    @store_item = StoreItem.find_by_id params[:item_id]
    @price = @store_item.unit_price
    @qty = @store_item.quantity
  end

  def indent_pdf
    @indent = Indent.find(params[:id], :include=> [:indent_items] )
    @total = 0
    @indent.indent_items.each do |i|
      @total  += ( i.required *  i.price )
    end
    render :pdf=>'indent_pdf'
  end

  def update_storeitem
    @store =  Store.find params[:item_id],:include=>:store_items
    @store_items = @store.store_items

  end

  def dynamic_items
    @store_items = StoreItem.find(:all)
  end


  def set_manager
    @reporting_manager =  @current_user.employee_record.reporting_manager_id  unless @current_user.employee_record.nil?
    @dept              =  @current_user.employee_record.employee_department_id unless @current_user.employee_record.nil?
  end

 private

  def get_indent(indent_id)
     Indent.find(params[:id])
  end

end

