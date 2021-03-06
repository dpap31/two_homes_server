require 'rspec_api_documentation_helper'

RSpec.resource 'Conversations' do
  header 'Content-Type', 'application/vnd.api+json'

  shared_context 'conversation parameters' do
    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be conversation.
    DESC
    let ('type'){'conversations'}
    parameter 'name', <<-DESC, scope: :attributes, required: true
      The user facing conversation name.
    DESC
  end

  shared_context "with a persisted conversation" do
    let!(:persisted_conversation) { FactoryGirl.create(:conversation) }
    let ("conversation_id") { persisted_conversation.id.to_s }
  end

  post '/v1/conversations' do
    include_context 'conversation parameters'
    let('name') { 'fake conve' }
    before do
      @current_user = FactoryGirl.create(:user)
      access_token = Doorkeeper::AccessToken.create!(resource_owner_id: @current_user.id).token
      header "Authorization", "Bearer #{access_token}"
    end

    example_request 'POST /v1/conversations' do
      expect(status).to eq 201
      conversation = Conversation.find(JSON.parse(response_body)['data']['id'])
      expect(conversation.name).to eq send('name')
      expect(conversation.users.count).to eq(1)
      expect(conversation.users.first.id).to eq(@current_user.id)
    end
  end

  get "/v1/conversations/:conversation_id" do
    let!(:persisted_conversation) { FactoryGirl.create(:conversation) }
    let(:conversation_id){ persisted_conversation.id.to_s }
    example_request 'PATCH /v1/conversations/:conversation_id' do
      expect(status).to eq 200
    end
  end

  patch "/v1/conversations/:conversation_id" do
    include_context 'conversation parameters'
    parameter 'id', <<-DESC, required: true
      The conversation ID.
    DESC
    let!(:persisted_conversation) { FactoryGirl.create(:conversation) }
    let('conversation_id') { persisted_conversation.id.to_s }
    let('id') { persisted_conversation.id.to_s }
    include_context 'conversation parameters'
    let('name') { 'fake convo name' }
    example_request 'PATCH /v1/conversations/:conversation_id' do
      expect(status).to eq 200
      conversation = JSON.parse(response_body)
      expect(conversation['data']['attributes']['name']).to eq('fake convo name')
    end
  end

  get "/v1/conversations" do
    before { FactoryGirl.create_list(:conversation, 2) }
    example_request 'GET /v1/conversations' do
      expect(status).to eq 200
      conversations = JSON.parse(response_body)
      expect(conversations['data'].size).to eq(2)
    end
  end

  get "/v1/conversations?filter[name]=foo" do
    before do
      FactoryGirl.create_list(:conversation, 2)
      FactoryGirl.create(:conversation, { name: 'foo' } )
    end
    example_request 'GET /v1/conversations?filter[name]=foo' do
      expect(status).to eq 200
    end
  end

  delete "/v1/conversations/:conversation_id" do
    include_context "with a persisted conversation"
    example_request "DELETE /v1/conversations/:conversation_id" do
      expect(status).to eq 204
    end
  end
end
