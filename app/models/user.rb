class User < ApplicationRecord
  before_save { username.downcase! }
  validates :username,
            presence: true,
            length: { maximum: 50, minimum: 3 },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 8 }

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end
