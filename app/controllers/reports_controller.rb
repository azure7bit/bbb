class ReportsController < ApplicationController
  before_filter :authenticate_user!
  # load_and_authorize_resource

  def index
    @items = Item.stock_by_item.order(:code)
    @suppliers = Supplier.list_all(current_user)
    @customers = Customer.order(:code)
  end
  
  def create
    report = Report.generate_report(params)
    send_file(report, :type => 'xls')
  end

  def preview
    @report_type = params[:reports][:report_type]
    @previews = Report.preview(params)
    respond_to do |format|
      format.js {render :layout => false}
    end    
  end
end