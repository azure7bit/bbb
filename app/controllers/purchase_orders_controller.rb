class PurchaseOrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_purchase_order, only: [:edit, :update, :destroy]
  before_filter :get_suppliers, only: [:new, :edit]
  before_filter :get_po_number, only: [:new]

  def index
    @purchase_orders = PurchaseOrder.order(:po_number)
  end

  def new;end

  def supplier_info
    supplier_info = Supplier.find(params[:purchase_order][:supplier_id])
    render json: supplier_info
  end

  def supplier_items
    @supplier_items = Supplier.find(params[:purchase_order][:supplier_id]).items
    respond_to do |format|
      format.js
    end
  end

  def item_detail
    @supplier = Supplier.find(params[:purchase_order][:supplier_id])
    @po_item = Item.find(params[:purchase_order][:item_id])
    respond_to do |format|
      format.js
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