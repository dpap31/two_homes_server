class V1::MembershipResource < JSONAPI::Resource
  has_one :user
  has_one :parenting_group

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
