class ChangeColumnPriceToVideo < ActiveRecord::Migration
  def change
    change_column :videos, :price, "float USING CAST(price AS float)"
  end
end
