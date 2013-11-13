class CategoriesController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :find_category, only: [:edit, :update, :destroy]

  def index
     @categories = Category.order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.save ? (redirect_to categories_path; flash[:notice] = "Category has been created successfully.") : (render :new)
  end

  def show;end

  def edit;end

  def update
    @category.update_attributes(params[:category])
    @category.save ? (redirect_to categories_path) : (render :edit)
  end

  def destroy
    if @category.destroy
      redirect_to categories_path
      flash[:notice] = "Category has been deleted successfully."
    end
  end

  def delete_all
    categories = Category.where("id in (?)", params[:id_all])
    categories.each { |category| category.destroy }
    render :json => categories
  end

  private
    def find_category
      @category = Category.find(params[:id])
    end  
end