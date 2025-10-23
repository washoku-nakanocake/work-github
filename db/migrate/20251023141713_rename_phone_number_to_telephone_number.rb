class RenamePhoneNumberToTelephoneNumber < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :phone_number, :telephone_number
  end
end