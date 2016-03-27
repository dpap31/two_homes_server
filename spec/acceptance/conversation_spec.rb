require 'rspec_api_documentation_helper'

RSpec.resource 'Users' do
  header 'Content-Type', 'application/vnd.api+json'
  shared_context 'user parameters' do
    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be conversation.
    DESC
    let ('type'){'conversation'}
    parameter 'code', <<-DESC, scope: :attributes, required: true
      The password for the user.
    DESC
     parameter 'password', <<-DESC, scope: :attributes, required: true
      The password for the conversation.
    DESC
  end
end
