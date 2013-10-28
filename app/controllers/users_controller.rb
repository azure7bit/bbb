class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@users = User.all
  end

  def new;end

  def create;end

  def edit;end

  def show;end

  def destroy;end

end
