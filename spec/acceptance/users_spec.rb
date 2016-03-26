require 'rspec_api_documentation_helper'

RSpec.resource 'Users' do
  header 'Content-Type', 'application/vnd.api+json'
  shared_context 'user parameters' do
    parameter :email, "User email" , scope: :attributes, required: true
    parameter :first_name, "User first name", scope: :attributes, required: true
    parameter :last_name , "User last name" ,scope: :attributes, required: true
    parameter :persona, "User persona", scope: :attributes, required: true
  end

  post '/v1/users' do
    include_context 'user parameters'
    let(:email) { 'test@test.com' }
    let(:first_name) { 'Drew' }
    let(:last_name) { 'Pappas' }
    let(:persona) { :user }

    example_request "POST /v1/users" do
      puts request
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["email-address"]).to eq send("email-address")
    end
  end
end


