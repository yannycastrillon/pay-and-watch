class ChangeUsersColumnName < ActiveRecord::Migration
  def change
    remove_column :users, :password_confirmation, :string
    add_column :users, :pass_confirm, :string, null:false
  end
end
