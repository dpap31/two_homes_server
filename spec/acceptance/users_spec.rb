require 'rspec_api_documentation_helper'

RSpec.resource 'Users' do
  header 'Content-Type', 'application/vnd.api+json'
  shared_context 'user parameters' do
    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be users.
    DESC
    let ('type'){'users'}
    parameter 'first-name', <<-DESC, scope: :attributes, required: true
      The given name of the user.
    DESC
    parameter 'last-name', <<-DESC, scope: :attributes, required: true
      The surname of the user.
    DESC
    parameter 'email', <<-DESC, scope: :attributes, required: true
      The email address of the user.
    DESC
    parameter 'password', <<-DESC, scope: :attributes, required: true
      The password for the user.
    DESC
    parameter 'persona', <<-DESC, scope: :attributes, required: true
      The users persona.
    DESC
  end

  post '/v1/users' do
    include_context 'user parameters'
    let('email') { 'test@test.com' }
    let('first-name') { 'Drew' }
    let('last-name') { 'Pappas' }
    let('persona') { 0 }
    let('password') { 'password' }

    example_request 'POST /v1/users' do
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user['data']['attributes']['email']).to eq send('email')
    end
  end

  get "/v1/users/:user_id" do
    let!(:persisted_user) { FactoryGirl.create(:user) }
    let(:user_id){ persisted_user.id.to_s }
    example_request 'PATCH /v1/users/:user_id' do
      expect(status).to eq 200
    end
  end

  patch "/v1/users/:user_id" do
    parameter 'id', <<-DESC, required: true
      The users ID.
    DESC
    let!(:persisted_user) { FactoryGirl.create(:user) }
    let('user_id') { persisted_user.id.to_s }
    let('id') { persisted_user.id.to_s }
    include_context 'user parameters'
    let('first-name') { 'Leonidas' }
    example_request 'PATCH /v1/users/:user_id' do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user['data']['attributes']['first-name']).to eq('Leonidas')
    end
  end

  get "/v1/users" do
    before { FactoryGirl.create_list(:user, 2) }
    example_request 'GET /v1/users' do
      expect(status).to eq 200
      users = JSON.parse(response_body)
      expect(users['data'].size).to eq(2)
    end
  end

  get "v1/users/me" do
    let!(:persisted_user) { FactoryGirl.create(:user, password: '12536475') }
    let(:access_token  ) { Doorkeeper::AccessToken.create!(resource_owner_id: persisted_user.id) }
    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request 'GET /v1/users/me' do
      explanation "The special 'me' id for the users resource will return the currently authenticated user."
      expect(status).to eq(200)
      expect(JSON.parse(response_body)['data']['attributes']['email']).to eq(persisted_user.email)
    end
  end
end

