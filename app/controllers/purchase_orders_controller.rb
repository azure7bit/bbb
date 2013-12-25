class PurchaseOrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_purchase_order, only: [:show]
  before_filter :get_suppliers, only: [:new]
  before_filter :get_po_number, only: [:new]

  def index
    @purchase_orders = PurchaseOrder.order(:po_number)
  end

  def new;end

  def create
    @purchase_order = PurchaseOrder.new(params[:purchase_order])
    @purchase_order.po_date = Date.strptime(params[:purchase_order][:po_date], '%Y-%m-%d').strftime("%Y-%m-%d")
    @purchase_order.user_id = current_user.id

    respond_to do |format|
      if @purchase_order.save
        params[:purchase_order][:item_ids].each do |item|
          item_id = item
          qty = params[:purchase_order][:item_qtys][item].to_i
          price = params[:purchase_order][:item_prices][item].to_d
          notes = params[:purchase_order][:item_notes][item]
          subtotal = qty * price
          ppn = subtotal * 0.1
          total = subtotal * 1.1

          purchase_order_details = @purchase_order.purchase_order_details.build(
              :item_id => item_id,
              :qty => qty,
              :price => price,
              :notes => notes,
              :subtotal => subtotal,
              :ppn => ppn,
              :total => total
            )
          purchase_order_details.save
        end
        flash[:notice] = "Purchase Order has been created successfully."
        @redirect_path = purchase_orders_path
        format.js {render :layout => false}
      else
        format.js {render :layout => false}
      end
    end
  end

  def show;end

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