class Public::SessionsController < Devise::SessionsController
  before_action :reject_inactive_customer, only: :create

  def after_sign_in_path_for(_resource) = customers_my_page_path

  private
  def reject_inactive_customer
    customer = Customer.find_by(email: params[:customer][:email])
    return if customer.nil?
    return unless customer.valid_password?(params[:customer][:password])
    redirect_to new_customer_registration_path, alert: "退会済みアカウントです。" unless customer.is_active?
  end
end