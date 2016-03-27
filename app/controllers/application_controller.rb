class ApplicationController < JSONAPI::ResourceController

  def current_user
    @current_user ||= current_resource_owner
  end

  def current_resource_owner
    return unless valid_doorkeeper_token?
    User.find(doorkeeper_token.resource_owner_id)
  end
end

