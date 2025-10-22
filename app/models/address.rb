class Address < ApplicationRecord
  belongs_to :customer
  validates :postal_code, :address, :name, presence: true
end