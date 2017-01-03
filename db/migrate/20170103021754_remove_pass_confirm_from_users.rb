class RemovePassConfirmFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :pass_confirm, :string
  end
end
