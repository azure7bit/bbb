class UserSessionsController < Devise::SessionsController

  def create
    if request.format == :mobile && (params[:user][:login]).downcase == 'admin'
      sign_out(resource)
      flash[:alert] = "Sorry, this version of application is not available for Administrator."
      redirect_to new_user_session_path
    else
      super
    end
  end
end