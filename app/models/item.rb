class Item < ApplicationRecord
  enum status: { on_sale: 0, off_sale: 1 } #販売ステータス用enum
end
