class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end


# ゆんゆんが追加しました
class Order < ApplicationRecord
  enum status: { 入金確認中: 0, 入金完了: 1 }
end