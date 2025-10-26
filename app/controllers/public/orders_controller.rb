class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
    
  def new
  end

  def index
    @orders = current_customer.orders
             .includes(order_details: :item)
             .order(created_at: :desc)
             .page(params[:page]).per(10)
  end
    
  def show
    @order = current_customer.orders.find_by(id: params[:id])
    unless @order
      flash[:alert] = "指定された注文は存在しないか、アクセス権がありません。"
      redirect_to orders_path and return
    end
    @order_details= OrderDetail.where(order_id: @order.id)
  end 
    
  def thanks
  end
    
  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_cost = 800
    @selected_payment_method = params[:order][:payment_method]
      
    ary = []
      @cart_items.each do |cart_item|
        item_price_with_tax = (cart_item.item.price_without_tax * 1.1).floor
        ary << item_price_with_tax*cart_item.amount
      end
    @cart_items_price_with_tax = ary.sum
    @total_payment = @cart_items_price_with_tax

    @address_type = params[:order][:address_type]
    case @address_type
      
      when "customer_address"
        @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
      
      when "registered_address"
        if params[:order][:registered_address_id].blank?
          flash.now[:alert] = "登録済住所を選択してください。"
          render :new and return
	      else
	        selected = Address.find(params[:order][:registered_address_id])
          @selected_address = selected.postal_code + " " + selected.address + " " + selected.name
	      end
      
      when "new_address"
        new_postal_code = params[:order][:new_postal_code]
        new_address = params[:order][:new_address]
        new_name = params[:order][:new_name]
        if new_postal_code.blank? || new_address.blank? || new_name.blank?
          flash.now[:alert] = "新しいお届け先の項目はすべて入力してください。"
          render :new and return
	      else
	        @selected_address = new_postal_code + " " + new_address + " " + new_name
	      end
      end
    end
    
  def create
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @cart_items = CartItem.where(customer_id: current_customer.id)
    ary = []
      @cart_items.each do |cart_item|
        item_price_with_tax = (cart_item.item.price_without_tax * 1.1).floor
        ary << item_price_with_tax*cart_item.amount
      end
    @order.total_payment = ary.sum
    @order.payment_method = params[:order][:payment_method]
      if @order.payment_method == "credit_card"
        initial_making_status = 1
      else
        initial_making_status = 0
      end
    @order.status = (@order.payment_method == "credit_card") ? 1 : 0
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:address]
    @order.name = params[:order][:name]
    
    if @order.save
      @cart_items.each do |cart_item|
        item_price_with_tax = (cart_item.item.price_without_tax * 1.1).floor
        OrderDetail.create!(
          order_id: @order.id, 
          item_id: cart_item.item.id, 
          price: item_price_with_tax,
          amount: cart_item.amount, 
          making_status: initial_making_status
        )
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      render :new
    end
  end
end
