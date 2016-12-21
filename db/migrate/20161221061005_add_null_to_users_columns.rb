class AddNullToUsersColumns < ActiveRecord::Migration
  def change
    change_column_null :users, :name, null:false
    change_column_null :users, :username, null:false
    change_column_null :users, :email, null:false
    change_column_null :users, :age, null:false
  end
end
