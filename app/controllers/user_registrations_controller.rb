class UserRegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [:new, :create]

  def edit
    session[:return_to] = request.env["HTTP_REFERER"]
    super
  end

  private

  def require_no_authentication
    if current_user
      current_user.is_admin? ? (redirect_to :back) : (return super)
    else
      redirect_to root_path
    end
  end

end