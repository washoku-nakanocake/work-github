class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  # カート内の商品を表示
  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @total_payment = 0
  end

  def create
    item = Item.find(cart_item_params[:item_id])
    amount = cart_item_params[:amount].to_i
    cart_item = current_customer.cart_items.find_by(item_id: item.id)

    if cart_item
      # 既存の商品があれば数量を更新
      cart_item.amount += amount
    else
      # なければ新しいCartItemを作成
      cart_item = current_customer.cart_items.build(item: item, amount: amount)
    end

    if cart_item.save
      redirect_to cart_items_path, notice: "#{item.name}をカートに追加しました。"
    else
      # エラー処理
      redirect_to item_path(item), alert: "カートに追加できませんでした。"
    end
  end

  # カート内の商品を更新
  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "数量を変更しました。"
    else
      redirect_to cart_items_path, alert: "数量の変更に失敗しました。"
    end
  end

  # カートから商品を削除
  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "#{@cart_item.item.name}をカートから削除しました。"
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました。"
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
