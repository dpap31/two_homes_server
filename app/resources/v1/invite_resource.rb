class V1::InviteResource < JSONAPI::Resource
  has_one :sender
  has_one :parenting_group
  has_one :recipient

  attribute :email
  attribute :accepted
  attribute :token

  filter :token

  after_create :add_current_user_to_invite

  def add_current_user_to_invite
    @model.sender = context[:current_user]
    @model.save!
  end

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
