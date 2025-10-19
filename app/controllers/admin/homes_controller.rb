class Admin::HomesController < ApplicationController
  # controller/concearns/admin_authenticate.rbから
  include AdminAuthenticate
  def top
    # 20行まで
    @orders = Order.includes(:customer).recent.page(params[:page]).per(20)
  end
end