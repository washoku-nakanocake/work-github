class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    
    if @order_detail.update(order_detail_params)
      
      if @order_detail.making_status == "in_making"
        @order.update(status: "in_making")
      end

      is_all_making_completed = @order_details.all? { |detail| detail.making_status == "making_completed" }
      
      if is_all_making_completed
        @order.update(status: "preparing_for_shipment")
      end
      
    end
    
    redirect_to admin_order_path(@order)
  end
end
