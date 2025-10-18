class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.amount :integer
      t.price :integer
      t.making_status :integer

      t.timestamps
    end
  end
end
