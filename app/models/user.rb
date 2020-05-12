class User < ActiveRecord::Base
  has_many :orders
  has_many :cartitems
  has_secure_password
  validates :first_name, presence: true
  validates :email_id, presence: true
end
