class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :type, null:false
      t.date :date, null:false
      t.integer :state_id, null:false
      t.string :state, null:false
      t.string :description

      t.timestamps null: false
    end
  end
end
