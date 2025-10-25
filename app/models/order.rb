class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_for_payment: 0, deposit_completed: 1, in_making: 2, preparing_for_shipment: 3, shipped: 4 }
end
