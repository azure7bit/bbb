class SuppliersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_supplier, only: [:edit, :update, :destroy, :list_supplier_items]

  def index
    @suppliers = Supplier.order(:first_name)
  end

  def new
    @supplier = Supplier.new
    @supplier.supplier_items.build
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
    @supplier.deactive ? (flash[:notice] = 'Supplier was successfully banned.') : (flash[:notice] = 'Supplier was not banned.')
    redirect_to suppliers_path
  end

  def delete_all
    suppliers = Supplier.where("id in (?)", params[:id_all])
    suppliers.each { |supplier| supplier.deactive }
    render :json => suppliers
  end

  def print_preview
    html = render_to_string(:template => "/suppliers/index.html.erb", :layout => false)
    pdf = PDFKit.new(html)
    # pdf.stylesheets << RAILS_ROOT + '/public/stylesheets/portal/pdf.css'
    pdf = pdf.to_file(RAILS_ROOT + '/pdfs/suppliers.pdf')
  end

  private
    def find_supplier
      @supplier = Supplier.find(params[:id])
    end
end