require 'rails_helper'

describe 'POST /api/v0/authentication/' do
  it_behaves_like 'an endpoint that requires client secret authorization', :post, '/api/v0/authentication/'

  context 'with valid credentials' do
    it 'returns a user' do
      user = create(:user)

      post '/api/v0/authentication/', params: {
        'user' => {
          'email' => user.email,
          'password' => attributes_for(:user)[:password]
        }
      }.to_json, headers: request_headers

      expect(response.status).to eq(200)
      expect(response_json).to eq('id' => user.id,
                                  'email' => user.email,
                                  'first_name' => user.first_name,
                                  'last_name' => user.last_name,
                                  'auth_token' => user.auth_token)
    end
  end

  context 'with invalid password' do
    it 'returns 404' do
      user = create(:user)

      post '/api/v0/authentication/', params: {
        'user' => {
          'email' => user.email,
          'password' => 'wrong_password'
        }
      }.to_json, headers: request_headers

      expect(response.status).to eq(404)
      expect(response.body).to be_empty
    end
  end

  context 'when user does not exist' do
    it 'returns 404' do
      post '/api/v0/authentication/', params: {
        'user' => {
          'email' => 'wrong@email.com',
          'password' => 'IRRELEVANT'
        }
      }.to_json, headers: request_headers

      expect(response.status).to eq(404)
      expect(response.body).to be_empty
    end
  end
end

describe 'DELETE /api/v0/authentication' do
  it_behaves_like 'an endpoint that requires client secret authorization', :delete, '/api/v0/authentication/'
  it_behaves_like 'an endpoint that requires user authentication', :delete, 'api/v0/authentication'

  it 'resets the authentication token of current user and responds with "204 No Content"' do
    user = create(:user)
    signed_in_authentication_token = user.auth_token

    delete '/api/v0/authentication/', headers: request_headers(user: user)

    user.reload

    expect(response.status).to eq(204)
    expect(user.auth_token).not_to be_nil
    expect(user.auth_token).not_to eq(signed_in_authentication_token)
  end
end