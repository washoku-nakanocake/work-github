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
      about_path #about_pathでいいでしょうか？
    end
  end
end