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
        @categories = Category.joins(:items => :supplier_items).where("supplier_items.supplier_id = ?", @sp.id).uniq
        format.js
      end
    end
  end

  def create
    @purchase_order = current_user.purchase_orders.build(params[:purchase_order])
    if @purchase_order.save
      flash[:notice] = "Purchase Order has been created successfully."
      redirect_to purchase_orders_path
    else
      render :new
    end
  end

  def show;end

  def supplier_info
    supplier = @suppliers.find_by_id(params[:purchase_orders][:supplier_id])
    render :json => supplier
  end

  def items_info
    item = Item.find_by_id(params[:item_id])
    render json: item.json_item(params[:supplier_id])
  end

  def supplier_items
    @supplier_items = Supplier.find(params[:purchase_order][:supplier_id]).items.order(:code)
    respond_to do |format|
      format.js
    end
  end

  def print_po
    # respond_to do |format|
    #   format.html do
    #     render :pdf => 'purchase_orders',
    #      :template => 'previews/purchase_orders/show',
    #      :layout => 'transaction.pdf',
    #      :save_only => false
    #   end
    # end
    render 'previews/purchase_orders/show', layout: 'print_view'
  end

  def return_number
    po_number = PurchaseOrder.find_next_available_number_for(date: params[:date])
    render json: po_number.to_json
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
