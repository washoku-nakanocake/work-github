class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました"
    else
      render :new
    end
  end


  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品を更新しました"
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :price_without_tax, :status, :image, :genre_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
