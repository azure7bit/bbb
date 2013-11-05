class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_by_user, :only => [:show, :edit, :destroy, :update]
  before_filter :fill_roles, :only => [:new, :edit, :show]

  load_and_authorize_resource

  def index
  	@users = User.account_member
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
    # success = params[:myrow_ids] ? delete_all : @user.deactive
    @user.deactive ? (flash[:notice] = 'User was successfully deleted.') : (flash[:notice] = 'User was not deleted.')
    redirect_to users_path
  end
    
  def delete_all
    users = User.where("id in (?)", params[:id_all])
    users.each { |user| user.deactive }
    render :json => users
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
end