class SupplierPaymentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :get_payment_number, only: [:new]
  before_filter :get_suppliers, only: [:index, :new, :create]
  
  def index;end

  def new
    @supplier_payment = SupplierPayment.new
  end

  def create
    @supplier_payment = SupplierPayment.new(params[:supplier_payment])
    @supplier_payment.user_id = current_user.id
    @supplier_payment.balance_type = "credit"
    @supplier_payment.save ? (redirect_to supplier_payments_path; flash[:notice] = "Supplier Payment has been saved successfully.") : (render :new)
  end


  def preview
    @payments = SupplierPayment.generate_balance(params[:supplier_payment][:supplier_id], params[:supplier_payment][:start_date], params[:supplier_payment][:end_date])
    respond_to do |format|
      format.js {render :layout => false}
    end    
  end

  def return_number
    payment_number = SupplierPayment.find_next_available_number_for(date: params[:date])
    render json: payment_number.to_json
  end

  private
    def get_payment_number
      @transaction_date = Date.today
      @payment_number = SupplierPayment.find_next_available_number_for
    end

    def get_suppliers
      @suppliers = Supplier.list_all(current_user)
    end
end