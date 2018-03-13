class RenameUserPhoneNumberColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :phone_number, :telegram_id
  end
end
