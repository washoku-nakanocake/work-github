class Public::CustomersController < ApplicationController
  include CustomerAuthenticate

  def show
    @customer = current_customer
  end

  def unsubscribe; end

  def withdraw
    current_customer.update!(is_active: false)
    reset_session
    redirect_to new_customer_registration_path, notice: "退会手続きが完了しました。"
  end
end