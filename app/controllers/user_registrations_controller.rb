class UserRegistrationsController < Devise::RegistrationsController
  before_filter :check_for_cancel, :only => [:update]

  prepend_before_filter :require_no_authentication, :only => [:new, :create]

  def edit
    session[:return_to] = request.env["HTTP_REFERER"]
    super
  end

  def check_for_cancel
    unless params[:cancel].blank?
      redirect_to session[:return_to]
    end
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def require_no_authentication
    if current_user
      current_user.is_admin? ? (return true) : (return super)
    else
      redirect_to root_path
    end
  end

end
