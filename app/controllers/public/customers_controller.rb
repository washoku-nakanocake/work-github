class Public::CustomersController < ApplicationController
  include CustomerAuthenticate
  before_action :set_customer, only: [:edit, :update, :show]
  
  def show
    @customer = current_customer
  end

  def unsubscribe; end

  def withdraw
    current_customer.update!(is_active: false)
    reset_session
    redirect_to new_customer_registration_path, notice: "退会手続きが完了しました。"
  end
  
  def edit; end

  def update
    if @customer.update(customer_params)
      redirect_to customers_my_page_path, notice: "会員情報を更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :postal_code, :address, :telephone_number, :email
    )
  end
end