class User < ActiveRecord::Base
  has_many :user_conversations
  has_many :conversations, through: :user_conversations

  has_many :memberships
  has_many :parenting_groups, through: :memberships
  has_many :invitations, class_name:'Invite', foreign_key: 'recipient_id'
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'


  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :persona, presence: true

  has_secure_password
  enum persona: [:user, :moderator]

  before_save :parse_initials_from_name

  def parse_initials_from_name
  	return false unless self.first_name[0] && self.last_name[0]
    self.initials = (self.first_name[0] + self.last_name[0]).upcase()
  end
end
