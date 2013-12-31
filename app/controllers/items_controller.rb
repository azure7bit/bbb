class ItemsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :items_order, only: [:index, :critical_items]
  before_filter :find_item, only: [:edit, :update, :destroy]
  before_filter :fill_categories, :only => [:new, :edit, :show]
  before_filter :find_item_category, :only => [:create, :update]

  def index;end

  def new
    @item = Item.new
  end

  def create
    item = @item_category.items.build(params[:item])
    item.code = Item.find_next_available_number_for(@item_category)
    item.save ? (redirect_to items_path; flash[:notice] = 'Item was successfully created.') : (render :new)
  end

  def show;end

  def edit;end

  def update
    params[:activate] ? @item.activate : @item.update_attributes(params[:item])
    @item.save ? (redirect_to items_path; flash[:notice] = 'Item was successfully updated.') : (render :edit)
  end

  def destroy
    @item.deactive ? (flash[:notice] = 'Item was successfully banned.') : (flash[:notice] = 'Item was not banned.')
    redirect_to items_path
  end

  def delete_all
    items = Item.where("id in (?)", params[:id_all])
    items.each { |item| item.deactive }
    render :json => items
  end

  def critical;end

  private

    def find_item
      @item = Item.find_by_id(params[:id])
    end

    def fill_categories
      @categories = Category.select(['id', 'name']).collect {|p| [ p.name, p.id ] }
    end

    def find_item_category
      @item_category = Category.find_by_id(params[:categories])
    end

    def items_order
      @items = Item.order(:code)
    end
end