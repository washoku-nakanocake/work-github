class ApplicationController < ActionController::Base
# concerns/adminなどを使いますので、beforeaction
  protected

  def after_sign_in_path_for(resource)
    resource.is_a?(Admin) ? admin_root_path : root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin || resource_or_scope.is_a?(Admin)
      new_admin_session_path
    else
      root_path #about_pathでいいでしょうか？
    end
  end

  def configure_permitted_parameters
  added = [
    :last_name, :first_name, :last_name_kana, :first_name_kana,
    :postal_code, :address, :phone_number
    ]
    devise_parameter_sanitizer.permit(:sign_up, keys: added)
    devise_parameter_sanitizer.permit(:account_update, keys: added)
  end
end