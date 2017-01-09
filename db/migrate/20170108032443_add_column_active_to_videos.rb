class AddColumnActiveToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :active, :boolean
    add_column :users, :active, :boolean
  end
end
