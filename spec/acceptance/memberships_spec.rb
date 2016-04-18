require 'rspec_api_documentation_helper'

RSpec.resource 'Memberships' do
  header 'Content-Type', 'application/vnd.api+json'

  shared_context 'memberships parameters' do
    let!(:user_model) { FactoryGirl.create(:user) }
    let!(:parenting_group_model) { FactoryGirl.create(:parenting_group) }

    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be memberships.
    DESC

    let ('type') { 'memberships' }

    parameter 'user', <<-DESC, required: true, scope: :relationships
      The user.
    DESC

    let "user" do
      {
        data: {
          type: "users",
          id: user_model.id.to_s
        }
      }
    end

    parameter 'parenting-group', <<-DESC, required: true, scope: :relationships
      The parenting group.
    DESC

    let "parenting-group" do
      {
        data: {
          type: "parenting-group",
          id: parenting_group_model.id.to_s
        }
      }
    end
  end

  post '/v1/memberships' do
    include_context 'memberships parameters'
    example_request 'POST /v1/memberships' do
      expect(status).to eq 201
    end
  end
end
