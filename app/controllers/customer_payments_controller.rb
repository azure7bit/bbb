class CustomerPaymentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :get_payment_number, only: [:new]
  before_filter :get_customers, only: [:index, :new, :create]
  
  def index;end

  def new
    @customer_payment = CustomerPayment.new
  end

  def create
    @customer_payment = CustomerPayment.new(params[:customer_payment])
    @customer_payment.user_id = current_user.id
    @customer_payment.balance_type = "debit"
    @customer_payment.save ? (redirect_to customer_payments_path; flash[:notice] = "Customer Payment has been saved successfully.") : (render :new)
  end


  def preview
    @payments = CustomerPayment.generate_balance(params[:customer_payment][:customer_id], params[:customer_payment][:start_date], params[:customer_payment][:end_date])
    respond_to do |format|
      format.js {render :layout => false}
    end    
  end

  def return_number
    payment_number = CustomerPayment.find_next_available_number_for(date: params[:date])
    render json: payment_number.to_json
  end

  private
    def get_payment_number
      @transaction_date = Date.today
      @payment_number = CustomerPayment.find_next_available_number_for
    end

    def get_customers
      @customers = Customer.order(:code)
    end
end