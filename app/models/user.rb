class User < ActiveRecord::Base
  has_secure_password
  validates :name, :username,:email, :age, presence: true
  validates :email, :username, uniqueness: true
  validates :age, numericality: {only_integer: true}
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
