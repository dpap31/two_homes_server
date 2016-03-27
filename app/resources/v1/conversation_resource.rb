module V1
  class ConversationResource < BaseResource
    has_many :user_conversations
    has_many :users

    attribute :code
    attribute :password

    class << self
      def creatable_fields(context)
        super
      end
      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:password]
    end
  end
end
