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
    @sales_invoice.user_id = current_user.id
    # @sales_invoice.save ? (redirect_to sales_invoices_path; flash[:notice] = 'Invoice has been created successfully.') : (redirect_to new_sales_invoice_path)
    respond_to do |format|
      if @sales_invoice.save
        flash[:notice] = "Invoice has been created successfully."
        @redirect_path = sales_invoices_path
        format.js {render :layout => false}
      else
        format.js {render :layout => false}
      end
    end
  end

  def show
  end

  def print_invoice
    respond_to do |format|
      format.html do
        render :pdf => 'sales_invoice',
         :template => 'sales_invoices/show',
         :layout => 'pdf_layout.pdf',
         :save_only => false
      end
    end
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
    render json: { 
      :item_id => item.id, :item_name => item.name, 
      :category_name => item.category_name, :item_price => item.retail_price,
      :valas_price => item.retail_price * Company.first.kurs,
      :item_stock => item.stock
    }
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
end