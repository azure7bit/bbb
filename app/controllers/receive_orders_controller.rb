class ReceiveOrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_po, only: [:new]
  before_filter :find_receive_order, only: [:show, :print_invoice]
  before_filter :list_receive_orders, only: [:index, :export]

  def index;end

  def show
    @receive_order = PoReceive.find_by_id(params[:id])
  end

  def new
    @receive_po = PoReceive.new
    @receive_po.po_receive_details.build
  end

  def create
    @receive_po = PoReceive.new(params[:po_receive])
    @receive_po.user_id = current_user.id
    if @receive_po.save
      params[:po_receive][:po_receive_details_attributes].each do |po_receive_detail|
        build_supplier_item_prices(params[:po_receive][:transaction_date], params[:po_receive][:supplier_id], po_receive_detail)
        SupplierItem.where("supplier_id = ? and item_id = ?", params[:po_receive][:supplier_id], po_receive_detail[1]["item_id"]).update_all(:price => price = po_receive_detail[1]["price"])
      end
      redirect_to purchase_orders_path
    else
      render :new
    end
  end

  def return_number
    receive_number = PoReceive.find_next_available_number_for(date: params[:date])
    render json: receive_number.to_json
  end

  def print_invoice
    respond_to do |format|
      format.html do
        render :pdf => 'receive_order',
         :template => 'previews/receive_orders/show',
         :layout => 'transaction.pdf',
         :save_only => false
      end
    end
  end

  def export
    respond_to do |format|
      format.xls
    end
  end

  private
    def find_po
      @po = PurchaseOrder.find_by_id(params[:id])
      @pr_date = Date.today
      @pr_number = PoReceive.find_next_available_number_for
      redirect_to "/404.html" if @po.closed?
    end

    def find_receive_order
      @receive_order = PoReceive.find_by_id(params[:id])
    end

    def list_receive_orders
      @receive_orders = PoReceive.order(:transaction_date)
    end

    def build_supplier_item_prices(date, supplier_id, po_receive_detail_params)
      supplier_item = SupplierItem.where("supplier_id = ? and item_id = ?", supplier_id, po_receive_detail_params[1]["item_id"]).first
      if supplier_item
        supplier_item_id = supplier_item.id
        item_id = supplier_item.item_id
        date_price = date
        price = po_receive_detail_params[1]["price"]

        SupplierItemPrice.create!([
          {
            :supplier_item_id => supplier_item_id,
            :item_id => item_id,
            :date_price => date_price,
            :price => price
          }
        ])
      end
    end
end
