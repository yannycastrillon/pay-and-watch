class AddReferenceColumnRequestsToUsers < ActiveRecord::Migration
  def change
    add_reference :requests, :user, index: true, foreign_key: true
    rename_column :requests, :type, :request_type
  end
end
