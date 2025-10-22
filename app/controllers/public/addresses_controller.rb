class Public::AddressesController < ApplicationController
  include CustomerAuthenticate

  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @address   = Address.new
    @addresses = current_customer.addresses.order(id: :desc)
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "配送先を登録しました。"
    else
      @addresses = current_customer.addresses.order(id: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path, notice: "配送先を削除しました。"
  end

  private
  def set_address
    # 本人のみが編集可能
    @address = current_customer.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end