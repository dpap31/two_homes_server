require 'rspec_api_documentation_helper'

RSpec.resource 'ParentingGroups' do
  header 'Content-Type', 'application/vnd.api+json'

  shared_context 'parenting-group parameters' do
    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be parenting-groups.
    DESC
    parameter 'name', <<-DESC, scope: :attributes
      The name of the Parenting Group.
    DESC
    let ('type'){'parenting-groups'}
  end

  shared_context "with a persisted parenting-group" do
    let!(:persisted_parenting_group) { FactoryGirl.create(:parenting_group) }
    let (:parenting_group_id) { persisted_parenting_group.id.to_s }
  end

  post '/v1/parenting-groups' do
    include_context 'parenting-group parameters'
    before do
      @current_user = FactoryGirl.create(:user)
      access_token = Doorkeeper::AccessToken.create!(resource_owner_id: @current_user.id).token
      header "Authorization", "Bearer #{access_token}"
    end

    example_request 'POST /v1/parenting-groups' do
      expect(status).to eq 201
      pg = ParentingGroup.find(JSON.parse(response_body)['data']['id'])
      expect(pg.users.count).to eq(1)
      expect(pg.users.first.id).to eq(@current_user.id)
    end
  end

  get "/v1/parenting-groups/:parenting_group_id" do
    let!(:persisted_parenting_group) { FactoryGirl.create(:parenting_group) }
    let(:parenting_group_id){ persisted_parenting_group.id.to_s }
    example_request 'PATCH /v1/parenting-groups/:parenting_group_id' do
      expect(status).to eq 200
    end
  end

  patch "/v1/parenting-groups/:parenting_group_id" do
    include_context 'parenting-group parameters'
    parameter 'id', <<-DESC, required: true
      The parenting-group ID.
    DESC
    let!(:persisted_parenting_group) { FactoryGirl.create(:parenting_group) }
    let(:parenting_group_id){ persisted_parenting_group.id.to_s }
    let(:id) { persisted_parenting_group.id.to_s }
    include_context 'parenting-group parameters'
    example_request 'PATCH /v1/parenting-groups/:parenting_group_id' do
      expect(status).to eq 200
    end
  end

  get "/v1/parenting-groups" do
    before { FactoryGirl.create_list(:parenting_group, 2) }
    example_request 'GET /v1/parenting-groups' do
      expect(status).to eq 200
      parenting_groups = JSON.parse(response_body)
      expect(parenting_groups['data'].size).to eq(2)
    end
  end

  delete "/v1/parenting-groups/:parenting_group_id" do
    include_context "with a persisted parenting-group"
    example_request "DELETE /v1/parenting-groups/:parenting_group_id" do
      expect(status).to eq 204
    end
  end
end
