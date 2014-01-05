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
    @sales_invoice = SalesInvoice.new(params[:sales_invoice])
    @sales_invoice.save ? (redirect_to sales_invoices_path; flash[:notice] = 'Invoice has been created successfully.') : (render :new)
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def customer_info
    customer = @customers.find_by_id(params[:sales_invoices][:customer_id])
    render :json => customer
  end

  def items_info
    item = Item.find_by_id(params[:item_id])
    render json: { :item_id => item.id, :item_name => item.name, :category_name => item.category_name, :item_price => item.retail_price }
  end

  private
    def find_sales_invoice
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
end