RSpec.describe 'OAuth password flow' do
  let(:email) { 'test@test.com' }
  let(:password) { 'password' }
  let!(:user) { FactoryGirl.create(:user, email: email, password: password) }

  it 'creates a token and returns it when creds are valid and get v1/users/me' do
    post '/oauth/token', grant_type: 'password', username: email, password: password
    expect(response.status).to eq(200)

    access_token = JSON.parse(response.body)['access_token']
    get '/v1/users/me', nil, {"Content-Type" => "application/vnd.api+json", "Authorization" => "Bearer #{access_token}"}
    me = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(me['data']['attributes']['email']).to eq(email)
  end

  it 'does not issue a token when creds are invalid' do
    post '/oauth/token', grant_type: 'password', username: email, password: 'foo'
    expect(response.status).to eq(401)
    expect(JSON.parse(response.body)['access_token']).to be_nil
  end
end
