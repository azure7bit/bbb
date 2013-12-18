class PurchaseOrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_purchase_order, only: [:edit, :update, :destroy]
  before_filter :get_suppliers, only: [:new, :edit]

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
      @suppliers = Supplier.order(:code)
    end

end