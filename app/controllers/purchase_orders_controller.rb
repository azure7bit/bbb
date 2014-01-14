class PurchaseOrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_purchase_order, only: [:show, :print_po]
  before_filter :get_suppliers, only: [:new, :supplier_info]
  before_filter :get_po_number, only: [:new]

  def index
    @purchase_orders = PurchaseOrder.order(:po_number)
  end

  def new
    @purchase_order = PurchaseOrder.new
    if params[:sp_id].present?
      respond_to do |format|
        @sp = Supplier.find_by_id(params[:sp_id])
        @categories = Category.joins(:items => :supplier_items).where("supplier_items.supplier_id = ?", @sp.id)
        format.js
      end
    end
  end

  def create
    @purchase_order = PurchaseOrder.new(params[:purchase_order])
    @purchase_order.save ? (redirect_to purchase_orders_path; flash[:notice] = 'Purchase Order has been created successfully.') : (redirect_to new_purchase_order_path)
  end

  def show;end

  def supplier_info
    supplier = @suppliers.find_by_id(params[:purchase_orders][:supplier_id])
    render :json => supplier
  end

  def items_info
    item = Item.find_by_id(params[:item_id])
    render json: { :item_id => item.id, :item_name => item.name, :category_name => item.category_name, :item_price => item.supplier_items.find_by_supplier_id(params[:supplier_id]).purchase_price }
  end

  def supplier_items
    # item_ids = params[:purchase_order][:item_ids] ? Supplier.find(params[:purchase_order][:supplier_id]).items.where("items.code not in (?)", params[:purchase_order][:item_ids].split(',')) : Supplier.find(params[:purchase_order][:supplier_id]).items
    @supplier_items = Supplier.find(params[:purchase_order][:supplier_id]).items.order(:code)
    respond_to do |format|
      format.js
    end
  end

  # def item_detail
  #   @supplier = Supplier.find(params[:purchase_order][:supplier_id])
  #   @po_item = Item.find(params[:purchase_order][:item_id])
  #   respond_to do |format|
  #     format.js
  #   end
  # end

  def print_po
    respond_to do |format|
      format.html do
        render :pdf => 'purchase_orders',
         :template => 'purchase_orders/show',
         :layout => 'pdf_layout.pdf',
         :save_only => false
      end
    end
  end

  def export
    @purchase_orders = PurchaseOrder.order(:po_number)
    respond_to do |format|
      format.xls
    end
  end

  private
    def find_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end  

    def get_suppliers
      @suppliers = Supplier.list_active
    end

    def get_po_number
      @po_date = Date.today
      @po_number = PurchaseOrder.find_next_available_number_for
    end

end