class PagesController < ApplicationController
  def routing_error
    redirect_to "/404.html"
  end
end
