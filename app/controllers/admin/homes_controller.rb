class Admin::HomesController < ApplicationController
  # controller/concearns/admin_authenticate.rbから
  include AdminAuthenticate
  def top
    # 10行まで
    @orders = Order.includes(:customer).recent.page(params[:page]).per(10)
  end
end