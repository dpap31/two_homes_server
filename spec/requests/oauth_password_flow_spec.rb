RSpec.describe 'OAuth password flow' do
  let(:email) { 'test@test.com' }
  let(:password) { 'password' }
  let!(:user) { FactoryGirl.create(:user, email: email, password: password) }

  it 'creates a token and returns it when creds are valid' do
    post '/oauth/token', grant_type: 'password', username: email, password: password
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['access_token']).not_to be_nil
  end

  it 'does not issue a token when creds are invalid' do
    post '/oauth/token', grant_type: 'password', username: email, password: 'foo'
    expect(response.status).to eq(401)
    expect(JSON.parse(response.body)['access_token']).to be_nil

  end

end
