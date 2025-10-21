class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:last_name, :first_name, :last_name_kana, :first_name_kana,
             :postal_code, :address, :telephone_number]
    )
  end

  def after_sign_up_path_for(_resource)
    customers_my_page_path
  end
end