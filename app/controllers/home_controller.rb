class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@statistic = Statistic.first
  end
  
end
