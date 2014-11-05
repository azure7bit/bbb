class ManageStocksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_item, :only => [:new]

  def index
    @items_stock = SalesInvoice.stock_not_updated
  end

  def new
  	@items = ManageStock.new
  end

  def create
    supplier_with_item = Hash[params[:supplier_ids].zip(params[:items_manage].map{|i| i})]
    invoice = SalesInvoiceDetail.where(:sales_invoice_id => params[:invoice_id], :item_id => params[:item].first).first
  	params[:supplier_ids].each do |manage_stock|
  		item = {:items_out => supplier_with_item[manage_stock], :supplier_id => manage_stock, :item_id => params[:item].first}
  		if supplier_with_item[manage_stock].to_i > 0
        m_stock = ManageStock.create(item)
        invoice.update_attributes(:stock_updated => true)
      end
  	end
    respond_to do |format|
      format.html { redirect_to manage_stocks_path }
      format.js { redirect_to manage_stocks_path }
    end
  end

  def edit
  end

  def update
  end

  private
  	def find_item
  		@item = SalesInvoiceDetail.where(:sales_invoice_id => params[:invoice_number], :item_id => params[:item_id])
      redirect_to manage_stocks_path if @item.first.stock_updated
  	end
end
