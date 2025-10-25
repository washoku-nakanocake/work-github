class Admin::OrderDetailsController < ApplicationController
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all # 注文に紐づく全ての商品を取得
    
    if @order_detail.update(order_detail_params)
      
      # 1. 1つの商品が「製作中」になったら、注文全体のステータスを「製作中」に更新
      if @order_detail.making_status == "in_making"
        @order.update(status: "in_making")
      end

      # 2. 全ての商品が「製作完了」になったら、注文全体のステータスを「発送準備中」に更新
      # all? メソッドを使って、全ての詳細が "making_completed" かどうかをチェック
      is_all_making_completed = @order_details.all? { |detail| detail.making_status == "making_completed" }
      
      if is_all_making_completed
        @order.update(status: "preparing_for_shipment")
      end
      
    end
    
    redirect_to admin_order_path(@order)
  end
end
