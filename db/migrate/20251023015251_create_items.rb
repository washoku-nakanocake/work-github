class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre, null: false, foreign_key: true
      t.string :name, null: false, index: true
      t.text :detail, null: false
      t.integer :price_without_tax, null: false, index: true
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
