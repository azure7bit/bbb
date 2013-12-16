class SuppliersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_supplier, only: [:edit, :update, :destroy, :list_supplier_items]

  def index
     @suppliers = Supplier.order(:first_name)
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    @supplier.save ? (redirect_to suppliers_path; flash[:notice] = 'Supplier has been created successfully.') : (render :new)
  end

  def show;end

  def edit;end

  def update
    @supplier.update_attributes(params[:supplier])
    @supplier.save ? (redirect_to suppliers_path) : (render :edit)
  end

  def destroy
    if @supplier.destroy
      redirect_to suppliers_path
      flash[:notice] = "Supplier has been deleted successfully."
    end
  end

  def delete_all
    suppliers = Supplier.where("id in (?)", params[:id_all])
    suppliers.each { |supplier| supplier.destroy }
    render :json => suppliers
  end

  private
    def find_supplier
      @supplier = Supplier.find(params[:id])
    end
end