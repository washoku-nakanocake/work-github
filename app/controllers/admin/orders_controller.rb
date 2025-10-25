class Admin::OrdersController < ApplicationController
  def order_params
    params.require(:order).permit(:status)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update 
    @order = Order.find(params[:id])
    @order_details = @order.order_details # OrderDetailの連動更新に使用
    
    if @order.update(order_params)
      # ★ 修正/確認: ステータスが "deposit_completed" (入金確認) になったら、
      # 全商品の製作ステータスを "waiting_for_making" (製作待ち) に更新
      if @order.status == "deposit_completed"
        @order_details.update_all(making_status: "waiting_for_making")
      end
    end
    
    redirect_to admin_order_path(@order)
  end
end
