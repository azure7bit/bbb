class RekAccountsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
before_filter :prepare_data, only:[:index, :new]
before_filter :load_type_account, only: :index
  def index
  	@rek_accounts = RekAccount.order(:number)
  end

  def new
    
  end

  def create
  	@rek_account = RekAccount.new(params[:rek_account])
  	if @rek_account.save
  		redirect_to rek_accounts_path
  	else
  		render :new
  	end
  end

  private
  	def prepare_data
      @rek_account = RekAccount.new
    end

    def load_type_account
      @type_accounts = TypeAccount.all
    end
end