class CustomersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_customer, only: [:edit, :update, :destroy]

  def index
    @customers = Customer.order(:code)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.code = Customer.find_next_available_number_for
    @customer.save ? (redirect_to customers_path; flash[:notice] = 'Customer has been created successfully.') : (render :new)
  end

  def show;end

  def edit;end

  def update
    params[:activate] ? @customer.activate : @customer.update_attributes(params[:customer])
    @customer.save ? (redirect_to customers_path) : (render :edit)
  end

  def destroy
    @customer.deactive ? (flash[:notice] = 'Customer was successfully banned.') : (flash[:notice] = 'Customer was not banned.')
    redirect_to customers_path
  end

  def delete_all
    customers = Customer.where("id in (?)", params[:id_all])
    customers.each { |customer| customer.deactive }
    render :json => customers
  end

  private
    def find_customer
      @customer = Customer.find(params[:id])
    end  
end