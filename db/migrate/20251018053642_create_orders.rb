class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.shipping_cost :integer
      t.payment_method :integer
      t.total_payment :integer
      t.status :integer
      t.postal_code :string
      t.address :string
      t.name :string

      t.timestamps
    end
  end
end
