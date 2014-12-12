class SuppliersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_supplier, only: [:edit, :update, :destroy, :list_supplier_items, :print_orders]
  before_filter :get_items, only: [:new, :edit]

  def index
    @suppliers = Supplier.list_all(current_user).order(:first_name)
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    @supplier.code = Supplier.find_next_available_number_for
    @supplier.save ? (redirect_to suppliers_path; flash[:notice] = 'Supplier has been created successfully.') : (render :new)
  end

  def show;end

  def edit;end

  def update
    params[:activate] ? @supplier.activate : @supplier.update_attributes(params[:supplier])
    @supplier.save ? (redirect_to suppliers_path) : (render :edit)
  end

  def destroy
    @supplier.destroy ? (flash[:notice] = 'Supplier was successfully banned.') : (flash[:notice] = 'Supplier was not banned.')
    redirect_to suppliers_path
  end

  def delete_all
    suppliers = Supplier.where("id in (?)", params[:id_all])
    suppliers.each { |supplier| supplier.deactive }
    render :json => suppliers
  end

  def print_preview
    if params[:id]
      template_pdf = 'previews/suppliers/items'
    else
      @suppliers = Supplier.where("id in (?)", params[:id_all].split(','))
      template_pdf = 'previews/suppliers/list'
    end
    render template_pdf, layout: 'print_view'
  end

  def print_orders
    render 'previews/suppliers/orders', layout: 'print_view'
  end

  def items_info
    item = Item.find_by_id(params[:item_id])
    render json: {
      :item_id => item.id,
      :item_name => item.name,
      :category_name => item.category_name
    }
  end

  private
    def find_supplier
      @supplier = Supplier.find(params[:id])
    end

    def get_items
      @categories = Category.all
    end
end
