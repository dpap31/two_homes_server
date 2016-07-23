class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :parenting_group
end
