class Admin::CustomersController < ApplicationController
  include AdminAuthenticate

  def index
    @customers = Customer.order(id: :asc).page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
