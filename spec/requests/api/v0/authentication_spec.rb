require 'rails_helper'

describe 'POST /api/v0/authentication/' do
  context 'with valid credentials' do
    it 'returns a user' do
      user = create(:user)

      post '/api/v0/authentication/', params: {
        'user' => {
          'email' => user.email,
          'password' => attributes_for(:user)[:password]
        }
      }.to_json, headers: json_headers

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
      }.to_json, headers: json_headers

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
      }.to_json, headers: json_headers

      expect(response.status).to eq(404)
      expect(response.body).to be_empty
    end
  end
end