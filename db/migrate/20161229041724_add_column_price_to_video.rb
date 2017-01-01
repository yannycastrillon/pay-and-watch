class AddColumnPriceToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :price, :float, null: false
  end
end
