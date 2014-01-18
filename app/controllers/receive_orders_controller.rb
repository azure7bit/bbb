class ReceiveOrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_po, only: [:new, :create]
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
    @receive_po.save ? (redirect_to purchase_orders_path) : (render :new)
  end

  def return_number
    receive_number = PoReceive.find_next_available_number_for(date: params[:date])
    render json: receive_number.to_json
  end

  def print_invoice
    respond_to do |format|
      format.html do
        render :pdf => 'receive_order',
         :template => 'receive_orders/show',
         :layout => 'pdf_layout.pdf',
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
    end

    def find_receive_order
      @receive_order = PoReceive.find_by_id(params[:id])
    end

    def list_receive_orders
      @receive_orders = PoReceive.order(:transaction_date)
    end
end
