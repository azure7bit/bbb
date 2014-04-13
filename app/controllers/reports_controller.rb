class ReportsController < ApplicationController
  before_filter :authenticate_user!
  # load_and_authorize_resource

  def index;end
  
  def create
    report = Report.generate_report(params[:reports][:report_type], params[:reports][:start_date], params[:reports][:end_date])
    send_file(report, :type => 'xls')
  end
end