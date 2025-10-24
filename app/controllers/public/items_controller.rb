class Public::ItemsController < ApplicationController

  def index
    @items = Item.order(created_at: :desc).page(params[:page]).per(8) 
    @total_count = Item.count
  end
end
