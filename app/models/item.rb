class Item < ApplicationRecord
  belongs_to :genre
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :detail
    validates :price_without_tax
    validates :is_active
  end
end
