class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def order_params
    params.require(:order).permit(:status)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update 
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    
    if @order.update(order_params)
      if @order.status == "deposit_completed"
        @order_details.update_all(making_status: "waiting_for_making")
      end
    end
    
    redirect_to admin_order_path(@order)
  end
end
