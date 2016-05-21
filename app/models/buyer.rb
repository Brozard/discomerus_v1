class Buyer < ActiveRecord::Base
  has_many :trade_events

  has_secure_password
  before_save { self.email = email.downcase }

  validates :company_name, 
            presence: true,
            length: { maximum:60 }
  validates :agent_name,
            presence: true,
            length: { maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum:50 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
end
