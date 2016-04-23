class Conversation < ActiveRecord::Base
  has_many :user_conversations
  has_many :users, through: :user_conversations
  belongs_to :parenting_group
end
