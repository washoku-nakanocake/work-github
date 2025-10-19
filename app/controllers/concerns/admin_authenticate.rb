# admin確認ためのmodule
module AdminAuthenticate
  extend ActiveSupport::Concern
  included do
    before_action :authenticate_admin!
  end
end