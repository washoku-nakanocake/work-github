class Public::ItemsController < ApplicationController

  def index
    @items = Item.order(created_at: :desc).page(params[:page]).per(8) 
    @total_count = Item.count
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def genre_search_result
    @genre_id = params[:genre_id]
    @genres = Genre.all
    @items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
    @total_count = @items.count
  end
end
