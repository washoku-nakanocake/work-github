# frozen_string_literal: true

class AddDeviseToAdminUsers < ActiveRecord::Migration[6.1]
  def up
    unless table_exists?(:admin_users)
      create_table :admin_users do |t|
        t.timestamps null: false
      end
    end

    change_table :admin_users, bulk: true do |t|
      t.string   :email,              null: false, default: "" unless column_exists?(:admin_users, :email)
      t.string   :encrypted_password, null: false, default: "" unless column_exists?(:admin_users, :encrypted_password)
      t.string   :reset_password_token           unless column_exists?(:admin_users, :reset_password_token)
      t.datetime :reset_password_sent_at         unless column_exists?(:admin_users, :reset_password_sent_at)
      t.datetime :remember_created_at            unless column_exists?(:admin_users, :remember_created_at)
    end

    add_index :admin_users, :email,                unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
  end

  def down
    remove_index :admin_users, :email                if index_exists?(:admin_users, :email)
    remove_index :admin_users, :reset_password_token if index_exists?(:admin_users, :reset_password_token)

    change_table :admin_users do |t|
      t.remove :remember_created_at     if column_exists?(:admin_users, :remember_created_at)
      t.remove :reset_password_sent_at  if column_exists?(:admin_users, :reset_password_sent_at)
      t.remove :reset_password_token    if column_exists?(:admin_users, :reset_password_token)
      t.remove :encrypted_password      if column_exists?(:admin_users, :encrypted_password)
      t.remove :email                   if column_exists?(:admin_users, :email)
    end
  end
end