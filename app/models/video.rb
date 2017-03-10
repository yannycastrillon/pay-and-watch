class Video < ActiveRecord::Base
  has_many :payments
  has_many :users, through: :payments
  validates :name, :url, :price, presence:true
  validates :price, numericality: true

  scope :actives,     ->{where(active:true)}
  scope :order_by_id, ->{order(:id)}
end
