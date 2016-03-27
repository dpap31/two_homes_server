module V1
  class UserConversationResource < BaseResource
    has_one :user
    has_one :conversation

    class << self
      def creatable_fields(context)
        super
      end
      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super
    end
  end
end
