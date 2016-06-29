module V1
  class ParentingGroupResource < BaseResource
    has_many :memberships
    has_many :users
    has_many :invites
    has_many :conversations

    attribute :created_at
    attribute :updated_at
    attribute :name

    after_create :add_current_user_to_parenting_group

    def add_current_user_to_parenting_group
      @model.users << context[:current_user]
    end

    class << self
      def creatable_fields(context)
        super - [:parenting_groups]
      end
      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super
    end
  end
end
