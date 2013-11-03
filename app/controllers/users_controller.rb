class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_by_user, :only => [:show, :edit, :destroy, :update]
  before_filter :fill_roles, :only => [:new, :edit]
  skip_before_filter :require_no_authentication, :only => [ :new, :create]

  def index
  	@users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save ? (redirect_to users_path; flash[:notice] = 'User was successfully created.') : (render :new)
  end

  def edit;end

  def show;end

  def destroy
    @user.destroy ? (redirect_to users_path; flash[:notice] = 'User was successfully deleted.') : (render :index)
  end

  def update    
    @user.update_attributes(params[:user])
    @user.save ? (redirect_to @user) : (render :edit)
  end

  private
    def find_by_user
      @user = User.find_by_id(params[:id])
    end

    def fill_roles
      @roles = Role.select(['id', 'name']).collect {|p| [ p.name, p.id ] }
    end

    def require_no_authentication
      current_user.is_admin? ? (return true) : (return super)
    end
end