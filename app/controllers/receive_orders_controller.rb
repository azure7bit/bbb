class ReceiveOrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_po, only: [:new, :create]

  def index
    @receive_orders = PoReceive.order(:transaction_date)
  end

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

  private
    def find_po
      @po = PurchaseOrder.find_by_id(params[:id])
      @pr_date = Date.today
      @pr_number = PoReceive.find_next_available_number_for
    end
end
