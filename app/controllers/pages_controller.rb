class PagesController < ApplicationController
	def routing_error
	    p "routing error path: #{params[:path]}"
	    redirect_to "/404.html"
  	end
end
