class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_company
  
  def edit
  end

  def update
    @company.update_attributes(params[:company])
    @company.save ? (redirect_to root_path) : (render :edit)
  end

  private

    def find_company
      @company = Company.first
    end
end