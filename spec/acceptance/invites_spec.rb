require 'rspec_api_documentation_helper'

RSpec.resource 'Invites' do
  header 'Content-Type', 'application/vnd.api+json'
  shared_context 'invite parameters' do
    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be invite.
    DESC
    let ('type'){'invites'}
    parameter 'email', <<-DESC, scope: :attributes, required: true
      The email of the person being invited.
    DESC
    parameter 'accepted', <<-DESC, scope: :attributes, required: true
      A flag to determine if the user has accepted the invite.
    DESC
    parameter 'token', <<-DESC, scope: :attributes, required: true
      A unique token used to associate the user registering with the correct parenting group.
    DESC
  end

  post '/v1/invites' do
    include_context 'invite parameters'
    let('email') { 'test@test.com' }
    let('accepted') { false }
    let('token') { 'abc123' }

    before do
      @current_user = FactoryGirl.create(:user)
      access_token = Doorkeeper::AccessToken.create!(resource_owner_id: @current_user.id).token
      header "Authorization", "Bearer #{access_token}"
    end

    example_request 'POST /v1/invites' do
      invite = JSON.parse(response_body)
      expect(invite['data']['attributes']['email']).to eq send('email')
      invite = Invite.find(JSON.parse(response_body)['data']['id'])
      expect(invite.sender.id).to eq(@current_user.id)
    end
  end

  get "/v1/invites/:invite_id" do
    let!(:persisted_invite) { FactoryGirl.create(:invite) }
    let(:invite_id){ persisted_invite.id.to_s }
    example_request 'PATCH /v1/invites/:invite_id' do
      expect(status).to eq 200
    end
  end
end

