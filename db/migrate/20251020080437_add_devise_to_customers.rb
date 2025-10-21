# frozen_string_literal: true

class AddDeviseToCustomers < ActiveRecord::Migration[6.1]
  def up
    unless table_exists?(:customers)
      create_table :customers do |t|
        t.timestamps null: false
      end
    end

    change_table :customers, bulk: true do |t|
      t.string   :email,              null: false, default: "" unless column_exists?(:customers, :email)
      t.string   :encrypted_password, null: false, default: "" unless column_exists?(:customers, :encrypted_password)
      t.string   :reset_password_token           unless column_exists?(:customers, :reset_password_token)
      t.datetime :reset_password_sent_at         unless column_exists?(:customers, :reset_password_sent_at)
      t.datetime :remember_created_at            unless column_exists?(:customers, :remember_created_at)
    end

    add_index :customers, :email,                unique: true unless index_exists?(:customers, :email)
    add_index :customers, :reset_password_token, unique: true unless index_exists?(:customers, :reset_password_token)
  end

  def down
    remove_index :customers, :email                if index_exists?(:customers, :email)
    remove_index :customers, :reset_password_token if index_exists?(:customers, :reset_password_token)

    change_table :customers do |t|
      t.remove :remember_created_at     if column_exists?(:customers, :remember_created_at)
      t.remove :reset_password_sent_at  if column_exists?(:customers, :reset_password_sent_at)
      t.remove :reset_password_token    if column_exists?(:customers, :reset_password_token)
      t.remove :encrypted_password      if column_exists?(:customers, :encrypted_password)
      t.remove :email                   if column_exists?(:customers, :email)
    end
  end
end