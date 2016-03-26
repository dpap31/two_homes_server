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
    parameter 'email', <<-DESC, scope: :attributes
      The email address of the user.
    DESC
    parameter 'password', <<-DESC, scope: :attributes
      The password for the user.
    DESC
    parameter 'persona', <<-DESC, scope: :attributes
      The users persona.
    DESC
  end

  post '/v1/users' do
    include_context 'user parameters'
    let('email') { 'test@test.com' }
    let('first-name') { 'Drew' }
    let('last-name') { 'Pappas' }
    let('persona') { 1 }
    let('password') { 'password' }

    example_request 'POST /v1/users' do
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user['data']['attributes']['email']).to eq send('email')
    end
  end
end


