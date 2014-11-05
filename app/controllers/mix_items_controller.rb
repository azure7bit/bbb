class MixItemsController < ApplicationController
  before_filter :authenticate_user!

  before_filter :find_item, only: [:edit, :show, :destroy, :update]
  before_filter :get_items, only: [:new, :edit]
  before_filter :fill_category_name, only: [:create]

  def index
    @items = Item.includes(:category).where("categories.name = 'Mix'")
  end

  def new
    @item = Item.new
    if params[:item_id].present?
      respond_to do |format|
        item = Item.find(params[:item_id])
        @items = item.supplier_items.collect{|supplier_item| ["#{supplier_item.item_name} - #{supplier_item.supplier.first_name}",supplier_item.id] }
        format.js
      end
    end
  end

  def create
    item = @category.items.build(params[:item])
    if item.save
      flash[:notice] = "Mix items has been created successfully."
      redirect_to mix_items_path
    else
      render :new
    end
  end

  def show;end

  def edit;end

  def update
    if @item.update_attributes(params[:item])
      flash[:notice] = "Mix items has been updated successfully."
      redirect_to mix_items_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = "Mix items has been deleted successfully."
    else
      flash[:alert] = "Mix items for delete failed."
    end
    redirect_to mix_items_path
  end

  private
    def find_item
      @item = Item.find(params[:id])
    end

    def get_items
      @categories = Category.all
    end

    def fill_category_name
      @category = Category.find_by_name('Mix')
    end
end
