class Video < ActiveRecord::Base
  has_many :payments
  has_many :users, through: :payments
  validates :name, :url, :price, presence:true
  validates :price, numericality: true

  scope :actives,     ->{where(active:true)}
  scope :inactives,   ->{where(active:false)}
  scope :order_by_id, ->{order(:id)}


  def set_defaults
    self.active = false if self.active.nil?
  end

  def activate_video
    self.active = true
    if self.save
      {success: "Video was successfully activate!"}
    else
      {error: "Video was not able to be activate!"}
    end
  end
end
