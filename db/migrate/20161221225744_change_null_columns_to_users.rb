class ChangeNullColumnsToUsers < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, null:false
    change_column :users, :email, :string, null:false
    change_column :users, :age, :integer, null:false
    change_column :users, :password_confirmation, :string, null:false
  end
end
