class CustomersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_customer, only: [:edit, :update, :destroy]

  def index
     @customers = Customer.order(:first_name)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.save ? (redirect_to customers_path; flash[:notice] = 'Customer has been created successfully.') : (render :new)
  end

  def show;end

  def edit;end

  def update
    @customer.update_attributes(params[:customer])
    @customer.save ? (redirect_to customers_path) : (render :edit)
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path
      flash[:notice] = "Customer has been deleted successfully."
    end
  end

  def delete_all
    customers = Customer.where("id in (?)", params[:id_all])
    customers.each { |customer| customer.destroy }
    render :json => customers
  end

  private
    def find_customer
      @customer = Customer.find_by_id(params[:id])
    end  
end