class Video < ActiveRecord::Base
  has_many :payments
  has_many :users, through: :payments
  validates :name, :url, :price, presence:true
  validates :price, numericality: true
end
