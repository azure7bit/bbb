class CustomersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_customer, only: [:edit, :update, :destroy]
  before_filter :list_customers, only: [:index, :export]
  before_filter :get_items, only: [:new, :edit]

  def index
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

  def items_info
    item = Item.find_by_id(params[:item_id])
    render json: { :item_id => item.id, :item_name => item.name, :category_name => item.category_name }
  end

  private
    def find_customer
      @customer = Customer.find(params[:id])
    end

    def list_customers
      @customers = Customer.order(:code)
    end

    def get_items
      @categories = Category.all
    end
end