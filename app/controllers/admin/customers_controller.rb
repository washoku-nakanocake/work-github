class Admin::CustomersController < ApplicationController
  include AdminAuthenticate
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.order(id: :asc).page(params[:page]).per(10)
  end

  def show; end
  def edit; end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。入力内容をご確認ください。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name,
      :last_name_kana, :first_name_kana,
      :postal_code, :address,
      :telephone_number, :email,
      :is_active
    )
  end
end