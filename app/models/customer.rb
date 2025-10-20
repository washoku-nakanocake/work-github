class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # 【ウッチャン追加】アソシエーション
  has_many :cart_items, dependent: :destroy
  # 【ウッチャン追加】アソシエーション

end