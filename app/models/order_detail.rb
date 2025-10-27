class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { making_unable: 0, waiting_for_making: 1, in_making: 2, making_completed: 3, }
end
