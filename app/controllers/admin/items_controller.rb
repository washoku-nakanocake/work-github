class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
  end

  def edit
  end
end
