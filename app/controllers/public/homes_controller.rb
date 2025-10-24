class Public::HomesController < ApplicationController
  
  def top
    @items = Item.order(created_at: :desc).limit(4)
    @genres = Genre.all
    @serch_items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
  end

end
