class SalesInvoicesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_sales_invoice, only: [:show]
  before_filter :get_customers, only: [:new]
  before_filter :get_sales_number, only: [:new]

  def index
    @sales_invoices = SalesInvoice.order(:invoice_number)
  end

  def new
    @sales_invoice = SalesInvoice.new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
    def find_sales_invoice
    end

    def get_customers
      @customers = Customer.list_active
    end

    def get_sales_number
    end

end
