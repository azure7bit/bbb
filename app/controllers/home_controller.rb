class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@statistic = Statistic.first
  end

  def purchase_history
  	ordered = PurchaseOrder.history_order
  	first_interval = 1.month*1000
  	point_start = 1.years.ago.at_midnight.to_i * 1000
  	render json: { ordered: ordered.map{|o| o[1].to_f}, first_interval: first_interval, point_start: point_start } 
  end
  
end
