# customer確認ためのmodule
# before_actionのかわりに、「include CustomerAuthenticate」で使用可能になります。
module CustomerAuthenticate
  extend ActiveSupport::Concern
  included { before_action :authenticate_customer! }
end