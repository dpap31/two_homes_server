class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :persona, presence: true

  has_secure_password

  #enum persona: [:user, :moderator]
end
