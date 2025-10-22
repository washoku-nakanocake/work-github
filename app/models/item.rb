class Item < ApplicationRecord
  # enum用
  enum status: { on_sale: 0, off_sale: 1 }
end
