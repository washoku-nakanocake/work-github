class Item < ApplicationRecord
  belongs_to :genre
  has_one_attached :image
  
  enum status: { on_sale: 0, off_sale: 1 } #販売ステータス用enum

  with_options presence: true do
    validates :name
    validates :detail
    validates :price_without_tax
    validates :is_active
  end
end
