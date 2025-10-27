# admin確認ためのmodule
# before_actionのかわりに、「include AdminAuthenticate」で使用可能になります。
module AdminAuthenticate
  extend ActiveSupport::Concern
  included do
    before_action :authenticate_admin!
  end
end