class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@statistic = Statistic.first
  end

  def purchase_history
  	ordered = PurchaseOrder.history_order
    render json: ordered.map{|o| [o[0].to_formatted_s(:long), o[1].to_f]}
  end

  def sales_history
    ordered = SalesInvoice.history_order
    render json: ordered.map{|o| [o[0].to_formatted_s(:long), o[1].to_f]}
  end
  
end
