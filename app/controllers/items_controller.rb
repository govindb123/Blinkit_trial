class ItemsController < ApplicationController
  before_action :require_seller
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
    @items = Item.includes(:category).all
  end

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: "Item added successfully!"
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: "Item updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "Item deleted successfully!"
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :category_id)
  end
end

