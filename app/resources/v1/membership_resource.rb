class V1::MembershipResource < JSONAPI::Resource
  has_one :user
  has_one :parenting_group

  filter :parenting_group_id
  filter :user_id

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
