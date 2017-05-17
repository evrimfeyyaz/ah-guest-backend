require 'rails_helper'

describe 'POST /api/v0/authentication/' do
  context 'with valid credentials' do
    it 'returns a user' do
      user = create(:user)

      post '/api/v0/authentication/', params: {
        'data' => {
          'type' => 'credentials',
          'attributes' => {
            'email' => user.email,
            'password' => attributes_for(:user)[:password]
          }
        }
      }

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
          'type' => 'credentials',
          'attributes' => {
            'email' => user.email,
            'password' => 'wrong_password'
          }
        }
      }

      expect(response.status).to eq(404)
      expect(response.body).to be_empty
    end

    it 'returns 404 when user does not exist' do
      post '/api/v0/authentication/', params: {
        'data' => {
          'type' => 'credentials',
          'attributes' => {
            'email' => 'wrong@email.com',
            'password' => 'some_password'
          }
        }
      }

      expect(response.status).to eq(404)
      expect(response.body).to be_empty
    end
  end
end