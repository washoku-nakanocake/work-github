class Public::HomesController < ApplicationController
  before_action :authenticate_customer!
  # index/new/create/show ...
end