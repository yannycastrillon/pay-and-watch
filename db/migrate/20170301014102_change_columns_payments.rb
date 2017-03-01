class ChangeColumnsPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :card_number, :string
    remove_column :payments, :exp_date, :date
    remove_column :payments, :card_sec_code, :integer
    remove_column :payments, :card_token, :string

    change_column :payments, :user_id, :integer, null: false
    change_column :payments, :video_id,:integer, null: false

    rename_column :payments, :billing_address, :address
    rename_column :payments, :email_address, :email
  end
end
