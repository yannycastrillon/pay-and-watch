class User < ActiveRecord::Base
  has_secure_password
  validates :name, :username,:email, :age, :password,:pass_confirm, presence: true
  validates :email, :username, uniqueness: true
  validates :age, numericality: {only_integer: true}
  validates :password, length: {in: 6..20}
end
