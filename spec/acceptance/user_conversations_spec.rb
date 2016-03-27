require 'rspec_api_documentation_helper'

RSpec.resource 'UserConversations' do
  header 'Content-Type', 'application/vnd.api+json'

  shared_context 'user_conversations parameters' do
    let!(:user_model) { FactoryGirl.create(:user) }
    let!(:conversation_model) { FactoryGirl.create(:conversation) }

    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be user-conversations.
    DESC

    let ('type') { 'user-conversations' }

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

    parameter 'conversation', <<-DESC, required: true, scope: :relationships
      The conversation.
    DESC

    let "conversation" do
      {
        data: {
          type: "conversations",
          id: conversation_model.id.to_s
        }
      }
    end
  end

  post '/v1/user-conversations' do
    include_context 'user_conversations parameters'
    example_request 'POST /v1/user-conversations' do
      expect(status).to eq 201
    end
  end
end
