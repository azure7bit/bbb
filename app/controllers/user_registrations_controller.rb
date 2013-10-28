class UserRegistrationsController < Devise::RegistrationsController

  respond_to :html, :js

  def new;end

  def create
    super
  end

end