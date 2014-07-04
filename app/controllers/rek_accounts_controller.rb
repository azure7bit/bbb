class RekAccountsController < ApplicationController
  before_filter :authenticate_user!
  # load_and_authorize_resource

  def index
    @rek_accounts = RekAccount.all
  end
end