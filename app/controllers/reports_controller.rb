class ReportsController < ApplicationController
  before_filter :authenticate_user!
  # load_and_authorize_resource

  def index;end
  
  def create
    report = Report.generate_report(params)
    send_file(report, :type => 'xls')
  end

  def preview
    @previews = Report.preview(params)
    respond_to do |format|
      format.js {render :layout => false}
    end    
  end
end