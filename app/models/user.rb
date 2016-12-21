class User < ActiveRecord::Base
  has_secure_password
  validates :name, :username, :password, :email, :age, presense: true
  validates :email, :username, uniqueness: true
  validates :age, numericality: {only_integer: true}
  validates :password, lengh: {in 6..20: true}
end
