class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :card_holder_name, null:false
      t.integer :card_number,     null:false
      t.date :exp_date,           null:false
      t.integer :card_sec_code,   null:false
      t.string :billing_address
      t.string :city,             null:false
      t.string :state_province,   null:false
      t.integer :postal_code
      t.string :email_address,    null:false

      t.timestamps null: false
    end
  end
end
