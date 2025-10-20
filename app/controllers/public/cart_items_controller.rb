class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @item = Item.find(params[:item_id])
    @cart_item = current_customer.cart_items.find_by(item_id: @item.id)

    if @cart_item
      # 既にカートに商品があれば数量を更新
      @cart_item.amount += params[:amount].to_i
      @cart_item.save
    else
      # 新しくカートに商品を追加
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.item = @item
      @cart_item.save
    end

    redirect_to cart_items_path
  end

  # カート内の商品を更新
  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end

  # カートから商品を削除
  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  # カート内の商品を表示
  def index
    @cart_items = current_customer.cart_items.includes(:item)
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
