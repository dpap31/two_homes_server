module V1
  class UserResource < BaseResource
    has_many :user_conversations
    has_many :conversations

    attribute :email
    attribute :first_name
    attribute :last_name
    attribute :persona
    attribute :password

    class << self
      def creatable_fields(context)
        super - [:conversations, :user_conversations]
      end
      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:password]
    end
  end
end
