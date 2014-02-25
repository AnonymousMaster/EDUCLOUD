class PurchaseOrdersController < ApplicationController
   before_filter :login_required
   filter_access_to :all


  def index
  @purchase_orders = PurchaseOrder.paginate(:all,:page=>params[:page],:include=>[:store], :conditions => ["(purchase_orders.po_no LIKE ? OR purchase_orders.po_status LIKE ? OR stores.name LIKE ? )","#{params[:search]}%","#{params[:search]}%","#{params[:search]}%"],:per_page => 30)
 end

  def show
    @purchase_order = PurchaseOrder.find(params[:id],:include=> [:purchase_items, {:purchase_items => :store_item}])
    @total =0
    @purchase_order.purchase_items.each do |i|
    @total  += ( i.quantity *  i.store_item.unit_price ) + ( i.quantity *  i.store_item.unit_price ) * (i.tax * 0.01) - ( i.quantity *  i.store_item.unit_price ) * (i.discount  * 0.01) unless i.tax.nil? or i.discount.nil?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase_order }
    end
  end

  def new
    @purchase_order = PurchaseOrder.new
    @last_purchase_order = PurchaseOrder.last.po_no unless PurchaseOrder.last.nil?
    @supplier = []
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase_order }
    end
  end


  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
    @supplier = []
  end

  def create
   @purchase_order = PurchaseOrder.new(params[:purchase_order])
     @supplier = []
#     @total =0
#    @purchase_order.purchase_items.each do |i|
#    @total  += ( i.quantity *  i.store_item.unit_price ) + ( i.quantity *  i.store_item.unit_price ) * (i.tax * 0.01) - ( i.quantity *  i.store_item.unit_price ) * (i.discount  * 0.01) unless i.tax.nil? or i.discount.nil?
#    end

    respond_to do |format|
      if @purchase_order.save
        flash[:notice] = 'Purchase Order was successfully created.'
        format.html { redirect_to(@purchase_order) }
        format.xml  { render :xml => @purchase_order, :status => :created, :location => @purchase_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @purchase_order = PurchaseOrder.find(params[:id])
    @supplier = []
      respond_to do |format|
      if @purchase_order.update_attributes(params[:purchase_order])
        flash[:notice] = 'Purchase Order was successfully updated.'
        format.html { redirect_to(@purchase_order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.destroy
     flash[:notice] = 'Purchase Order was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(purchase_orders_url) }
      format.xml  { head :ok }
    end
  end


 def po_pdf
   @purchase_order = PurchaseOrder.find(params[:id], :include=>:purchase_items)
    @total =0
    @purchase_order.purchase_items.each do |i|
     @total  += ( i.quantity *  i.store_item.unit_price ) + ( i.quantity *  i.store_item.unit_price ) * (i.tax * 0.01) - ( i.quantity *  i.store_item.unit_price ) * (i.discount  * 0.01) unless i.tax.nil? or i.discount.nil?
    end
   render :pdf=>'purchase_order_pdf'
  end


  def update_supplier
    @supplier =Supplier.find(:all,:conditions=>"supplier_type_id=#{params[:supplier_type_id]}" )
    render(:update) do |page|
      page.replace_html 'update_supplier', :partial=>'update_supplier'
    end
  end

  def po_accept
     @supplier = []
         @purchase_order = PurchaseOrder.find(params[:id], :include=>:purchase_items)
    unless  @purchase_order.purchase_items.nil?
       if @purchase_order.update_attributes(params[:purchase_order])
        if @purchase_order.po_status == "Accept"
	         @purchase_order.po_status = "Accepted"
           @purchase_order.save
           redirect_to :action=>"index"
       flash[:notice] = 'Purchase Order was successfully Accepted.'
       elsif @purchase_order.po_status == "Reject"
             @purchase_order.po_status= "Rejected"
             @purchase_order.save
          redirect_to :action => "index"
       flash[:notice] = 'Purchase Order was successfully Rejected.'
     else
           @purchase_order.po_status= "Pending"
           @purchase_order.save
    end
#redirect_to :controller=> "purchase_orders" , :action=>"index"
 end
end
end

end

