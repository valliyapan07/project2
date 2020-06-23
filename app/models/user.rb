class User < ActiveRecord::Base
  has_many :orders
  has_many :cartitems
  has_secure_password
  validates :first_name, presence: true
  validates :email_id, presence: true
  validates :password, length: { in: 6..20 }
  validates_uniqueness_of :email_id
  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def self.show
    User.all.where(role: "User")
  end

  def self.show1(from, to, user)
    Order.all.where("ordered_at > ? and ordered_at < ? and user_id = ?", from, to, user.id)
  end

  def self.show_checker
    User.all.where(role: "Bill Checker")
  end
end
