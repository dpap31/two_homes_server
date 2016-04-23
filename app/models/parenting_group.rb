class ParentingGroup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invites
  has_many :conversations
end
