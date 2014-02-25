class GrnsController < ApplicationController
  before_filter :login_required
  filter_access_to :all

  def index
    @grns = Grn.paginate(:all, :include =>[:purchase_order, :supplier, :supplier_type],  :page => params[:page],:per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grns }
    end
  end

  def show
    @grn = Grn.find(params[:id],:include=> [:grn_items,{:store=> :store_items}])
     @total =0
    @grn.grn_items.each do |i|
    @total  += ( i.quantity *  i.unit_price )+ ( i.quantity *  i.unit_price )* ( i.tax * 0.01)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grn }
    end
  end

  def new
    @supplier=[]
    @grn = Grn.new
    @last_grn = Grn.last.grn_no unless Grn.last.nil?
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grn }
    end
  end


  def edit
 @supplier= []
    @grn = Grn.find(params[:id], :include=> [:grn_items,{:store=> :store_items}])
       @grn.grn_items.each do |i|
       i.store_item.update_attributes!(:quantity => (i.store_item.quantity - i.quantity), :unit_price => i.unit_price)
       end
    @total =0
    @grn.grn_items.each do |i|
    @total  += ( i.quantity *  i.unit_price )+ ( i.quantity *  i.unit_price )* ( i.tax * 0.01)
    end
  end

  def create
    @grn = Grn.new(params[:grn])
    @supplier=[]
    notice= ""
    respond_to do |format|
        if @grn.save
        flash[:notice] = "GRN succesfully created " + notice
        format.html { redirect_to(@grn) }
        format.xml  { render :xml => @grn, :status => :created, :location => @grn }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grn.errors, :status => :unprocessable_entity }
      end
     end

  end

  def update
    @supplier=[]
    @grn = Grn.find(params[:id],:include=> [:grn_items,{:store=> :store_items}])
   notice=""
    respond_to do |format|

      if @grn.update_attributes(params[:grn])
       @grn.grn_items.each do |i|
       i.store_item.update_attributes!(:quantity => (i.store_item.quantity + i.quantity), :unit_price =>i.unit_price)
         notice <<  " #{(i.quantity).abs} #{i.store_item.item_name }   added to store   "
        flash[:notice] =  'GRN was successfully updated.'
       end
        format.html { redirect_to(@grn) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grn.errors, :status => :unprocessable_entity }
      end

  end
 end


  def destroy
    @grn = Grn.find(params[:id])
    @grn.destroy
   flash[:notice] = 'GRN was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(grns_url) }
      format.xml  { head :ok }
    end
  end


  def update_item
     @i =  params[:i]
     @store_item = StoreItem.find_by_id params[:item_id]
     @price = @store_item.unit_price
 end


 def grn_pdf
    @grn = Grn.find(params[:id], :include=> [:grn_items,{:store=> :store_items}])
    @total =0
    @grn.grn_items.each do |i|
    @total  += ( i.quantity *  i.unit_price )+ ( i.quantity *  i.unit_price )* ( i.tax * 0.01)
    end
    render :pdf=>'grn_pdf'
 end


  def update_supplier
      @supplier = Supplier.find(:all,:conditions=>"supplier_type_id=#{params[:supplier_type_id]}" )
      render(:update) do |page|
      page.replace_html 'update_supplier', :partial=>'update_supplier'
    end
  end

  def update_po
   @po  = PurchaseOrder.find_by_id params[:po_id], :include => [:purchase_items, {:store=> :store_items}]
   @supplier_type = @po.supplier_type_id
   @supplier      = @po.supplier_id
   @store         = @po.store_id

   @po.purchase_items.each do |po|
    @po_id = po.id
    po.store_item_id
    po.quantity
    po.store_item.unit_price
    po.tax
   end
   @grn = Grn.new
   @grn_items = @po.purchase_items

  end
  def report
     @start_date = params[:start]
     @end_date  = params[:end]
     inventory = FinanceTransactionCategory.find_by_name('Inventory').id
     @inventory_transactions = FinanceTransaction.find(:all,:conditions=> "transaction_date >= '#{@start_date}' and transaction_date <= '#{@end_date}'and category_id ='#{inventory}'")

   end

  def report_detail
    @grn_report = Grn.find(params[:id], :include=> [:grn_items,{:store=> :store_items}])
     inventory = FinanceTransactionCategory.find_by_name('Inventory').id
    @inventory_transactions = FinanceTransaction.find(:all,:conditions=> "transaction_date >= '#{@start_date}' and transaction_date <= '#{@end_date}'and category_id ='#{inventory}'")
    @user = @grn_report.purchase_order.indent.user unless @grn_report.purchase_order.indent.nil?
    @total =0
    @grn_report.grn_items.each do |i|
    @total  += ( i.quantity *  i.unit_price )+ ( i.quantity *  i.unit_price )* ( i.tax * 0.01)
    end
  end
end

