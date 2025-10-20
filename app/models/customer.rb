class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # 【ウッチャン追加】アソシエーション
  has_many :cart_items, dependent: :destroy
  # 【ウッチャン追加】アソシエーション

end


# ゆんゆんが追加しました
class Order < ApplicationRecord
  enum status: { 入金確認中: 0, 入金完了: 1 }
end