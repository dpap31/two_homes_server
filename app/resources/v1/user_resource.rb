module V1
  class UserResource < BaseResource
    has_many :user_conversations
    has_many :conversations

    has_many :memberships
    has_many :parenting_groups
    has_many :invitations

    attribute :email
    attribute :first_name
    attribute :last_name
    attribute :persona
    attribute :password
    attribute :initials
    attribute :full_name

    filter :first_name

    def full_name
      "#{@model.first_name} #{@model.last_name}"
    end

    class << self
      def creatable_fields(context)
        super - [:user_conversations, :memberships, :invitations]
      end
      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:password]
    end
  end
end
