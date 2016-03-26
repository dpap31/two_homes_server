class Conversation < ActiveRecord::Base
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :code, presence: true, uniqueness: true
  validates_uniqueness_of :sender_id, :scope => :recipient_id

  has_secure_password

  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id)
  end
end
