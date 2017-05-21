require 'rails_helper'

describe 'POST /api/v0/authentication/' do
  let(:json_headers) { { 'CONTENT_TYPE' => 'application/json' } }

  context 'with valid credentials' do
    it 'returns a user' do
      user = create(:user)

      post '/api/v0/authentication/', params: {
        'data' => {
          'type' => 'authentications',
          'attributes' => {
            'email' => user.email,
            'password' => attributes_for(:user)[:password]
          }
        }
      }.to_json, headers: json_headers

      expect(response.status).to eq(200)
      expect(response_json).to eq('data' => {
        'type' => 'users',
        'id' => user.id.to_s,
        'attributes' => {
          'email' => user.email,
          'first-name' => user.first_name,
          'last-name' => user.last_name,
          'auth-token' => user.auth_token
        }
      })
    end
  end

  context 'with invalid credentials' do
    it 'returns 404 when password is wrong' do
      user = create(:user)

      post '/api/v0/authentication/', params: {
        'data' => {
          'type' => 'authentications',
          'attributes' => {
            'email' => user.email,
            'password' => 'wrong_password'
          }
        }
      }.to_json, headers: json_headers

      expect(response.status).to eq(404)
      expect(response.body).to be_empty
    end

    it 'returns 404 when user does not exist' do
      post '/api/v0/authentication/', params: {
        'data' => {
          'type' => 'authentications',
          'attributes' => {
            'email' => 'wrong@email.com',
            'password' => 'some_password'
          }
        }
      }.to_json, headers: json_headers

      expect(response.status).to eq(404)
      expect(response.body).to be_empty
    end
  end
end