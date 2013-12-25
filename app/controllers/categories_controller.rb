class CategoriesController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_category, only: [:edit, :update, :destroy]

  def index
     @categories = Category.order(:code)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.code = Category.find_next_available_number_for
    @category.save ? (redirect_to categories_path; flash[:notice] = "Category has been created successfully.") : (render :new)
  end

  def show;end

  def edit;end

  def update
    params[:activate] ? @category.activate : @category.update_attributes(params[:category])
    @category.save ? (redirect_to categories_path) : (render :edit)
  end

  def destroy
    @category.deactive ? (flash[:notice] = 'Category was successfully banned.') : (flash[:notice] = 'Category was not banned.')
    redirect_to categories_path
  end

  def delete_all
    categories = Category.where("id in (?)", params[:id_all])
    categories.each { |category| category.deactive }
    render :json => categories
  end

  private
    def find_category
      @category = Category.find(params[:id])
    end  
end