class AddNotNullColumnToUsers < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, null:false
    change_column :users, :username, :string, null:false
    change_column :users, :email, :string, null:false
    change_column :users, :age, :integer, null:false
  end
end
