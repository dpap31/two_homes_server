module V1
  class ConversationResource < BaseResource
    has_many :user_conversations
    has_many :users
    has_one :parenting_group

    attribute :name

    filters :name

    after_create :add_current_user_to_conversation

    def add_current_user_to_conversation
      @model.users << context[:current_user]
    end

    class << self
      def creatable_fields(context)
        super - [:user_conversations]
      end
      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:password]
    end
  end
end
