class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :indexm :show, :thanks]
    
    def new
    end
    
    def confirm
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @shipping_cost = 800 #送料は800円で固定
      @selected_payment_method = params[:order][:payment_method]
      
      #以下、商品合計額の計算
      ary = []
        @cart_items.each do |cart_item|
          ary << cart_item.item.price*cart_item.amount
        end
      @cart_items_price = ary.sum
      
      @total_payment = @shipping_cost + @cart_items_price
      @address_type = params[:order][:address_type]
      case @address_type
      when "customer_address"
        @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
      when "registered_address"
        unless params[:order][:registered_address_id] == ""
          selected = Address.find(params[:order][:registered_address_id])
          @selected_address = selected.postal_code + " " + selected.address + " " + selected.name
	      else
	        render :new
	      end
      when "new_address"
        unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
	        @selected_address = params[:order][:new_postal_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
	      else
	        render :new
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
          ary << cart_item.item.price*cart_item.amount
        end
      @cart_items_price = ary.sum
      @order.total_payment = @order.shipping_cost + @cart_items_price
      @order.payment_method = params[:order][:payment_method]
        if @order.payment_method == "credit_card"
          @order.status = 1
        else
          @order.status = 0
        end
      
      address_type = params[:order][:address_type]
      case address_type
        when "customer_address"
        @order.postal_code = current_member.postal_code
        @order.address = current_member.address
        @order.name = current_member.family_name + current_member.first_name
        when "registered_address"
        Addresse.find(params[:order][:registered_address_id])
        selected = Addresse.find(params[:order][:registered_address_id])
        @order.postal_code = selected.postal_code
        @order.address = selected.address
        @order.name = selected.name
        when "new_address"
        @order.postal_code = params[:order][:new_postal_code]
        @order.address = params[:order][:new_address]
        @order.name = params[:order][:new_name]
      end
    
      if @order.save
        if @order.status == 0
          @cart_items.each do |cart_item|
            OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
          end
        else
          @cart_items.each do |cart_item|
            OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
          end
        end
        @cart_items.destroy_all
        redirect_to thanks_orders_path
      else
        render :items
      end
      end
    end
    
    def index
      @orders = Order.where(customer_id: current_customer_id).order(created_at: :desc).
    end
    
    def show
      @order = Order.find(params[:id])
      @order_details= OrderDetail.where(order_id: @order.id)
    end 
    
    def thanks
    end
end
