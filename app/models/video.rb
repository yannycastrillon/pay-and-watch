class Video < ActiveRecord::Base
  has_many :payments
  has_many :users, through: :payments
  validates :name, :url, :price, presence:true
  validates :price, numericality: true

  scope :actives,     -> { where(active: true) }
  scope :inactives,   -> { where(active: false) }
  scope :order_by_id, -> { order(:id) }


  def set_defaults
    return unless self.active.nil?
    self.active = false
  end

  def activate_video
    self.active = true
    self.save!
  end
end
