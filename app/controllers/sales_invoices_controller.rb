class SalesInvoicesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_sales_invoice, only: [:show]
  before_filter :get_customers, only: [:new, :customer_info]
  before_filter :get_sales_number, only: [:new]
  before_filter :get_items, only: [:new]

  def index
    @sales_invoices = SalesInvoice.order(:invoice_number)
  end

  def new
    @sales_invoice = SalesInvoice.new
  end

  def create
    @sales_invoice = current_user.sales_invoices.build(params[:sales_invoice])
    # respond_to do |format|
      if @sales_invoice.save
        @sales_invoice.sales_invoice_details.each do |sales_invoice_detail|
          build_customer_item_prices(@sales_invoice.transaction_date, sales_invoice_detail)
        end
        # add credit balance
        # CustomerPayment.create!([
        #   {
        #     :transaction_date => @sales_invoice.transaction_date,
        #     :invoice_number => @sales_invoice.invoice_number,
        #     :customer_id => @sales_invoice.customer_id,
        #     :notes => "Sale Invoice " + @sales_invoice.transaction_date.strftime("%d %B %Y"),
        #     :balance_type => "credit",
        #     :amount => @sales_invoice.grand_total,
        #     :user_id => current_user.id
        #   }])

        flash[:notice] = "Invoice has been created successfully."
        # @redirect_path = sales_invoices_path
        # format.js {render :layout => false}
        redirect_to sales_invoices_path
      else
        # format.js {render :layout => false}
        render :new
      end
    # end
  end

  def show;end

  def print_invoice
    # respond_to do |format|
    #   format.html do
    #     render :pdf => 'sales_invoice',
    #      :template => 'previews/invoices/invoice',
    #      :layout => 'transaction.pdf',
    #      :save_only => false
    #   end
    # end
    render 'previews/invoices/invoice', :layout => 'print_view'
  end

  def return_number
    so_number = SalesInvoice.find_next_available_number_for(date: params[:date])
    render json: so_number.to_json
  end

  def customer_info
    customer = @customers.find_by_id(params[:sales_invoices][:customer_id])
    render :json => customer
  end

  def items_info
    item = Item.find_by_id(params[:item_id])
    render json: item.json_item
  end

  def export
    @sales_invoices = SalesInvoice.order(:invoice_number)
    respond_to do |format|
      format.xls
    end
  end

  private
    def find_sales_invoice
      @sales_invoice = SalesInvoice.find_by_id(params[:id])
    end

    def get_customers
      @customers = Customer.list_active
    end

    def get_sales_number
      @invoice_date = Date.today
      @invoice_number = SalesInvoice.find_next_available_number_for
    end

    def get_items
      @categories = Category.all
    end

    def build_customer_item_prices(date, sales_invoice_detail_data)
      date_price = date
      item_id = sales_invoice_detail_data.item_id
      price = sales_invoice_detail_data.price

      CustomerItemPrice.create!([
        {
          :item_id => item_id,
          :date_price => date_price,
          :price => price
        }
      ])
    end
end