require 'rails_helper'

describe 'POST /api/v0/users/' do
  let(:json_headers) { { 'CONTENT_TYPE' => 'application/json' } }

  context 'with valid parameters' do
    it 'creates a user' do
      user_attributes = attributes_for(:user)

      post '/api/v0/users/', params: {
        'data' => {
          'type' => 'users',
          'attributes' => {
            'first-name' => user_attributes[:first_name],
            'last-name' => user_attributes[:last_name],
            'email' => user_attributes[:email],
            'password' => user_attributes[:password],
            'password-confirmation' => user_attributes[:password]
          }
        }
      }.to_json, headers: json_headers

      user = User.find_by(email: user_attributes[:email])
      expect(response.status).to eq(201)
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

  context 'with invalid parameters' do
    it 'does not create a user' do
      post '/api/v0/users/', params: {}.to_json, headers: json_headers

      expect(response.status).to eq(422)
      expect(response_json).to have_key('errors')
    end
  end
end