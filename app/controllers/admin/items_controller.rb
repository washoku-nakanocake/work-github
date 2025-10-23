class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to show
    else
      render new
    end
  end


  def show
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :price_without_tax, :is_active, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
