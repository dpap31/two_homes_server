class Conversation < ActiveRecord::Base
  has_many :user_conversations
  has_many :users, through: :user_conversations

  validates :code, presence: true, uniqueness: true
  has_secure_password

  def generate_code
    [*1..9].shuffle.insert(3,"-").take(7).join('')
  end
end
