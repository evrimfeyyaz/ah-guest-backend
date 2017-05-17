require 'rails_helper'

describe 'POST /api/v0/users/' do
  context 'with valid parameters' do
    it 'creates a user' do
      first_name = 'John'
      last_name = 'Doe'
      email = 'user@example.com'
      password = 'secret12345'

      post '/api/v0/users/', params: {
        'data' => {
          'type' => 'users',
          'attributes' => {
            'first-name' => first_name,
            'last-name' => last_name,
            'email' => email,
            'password' => password,
            'password-confirmation' => password
          }
        }
      }

      user = User.find_by(email: email)
      expect(response.status).to eq(201)
      expect(response_json).to eq('data' => {
        'type' => 'users',
        'id' => user.id.to_s,
        'attributes' => {
          'email' => user.email,
          'first-name' => user.first_name,
          'last-name' => user.last_name
        }
      })
    end
  end

  context 'with invalid parameters' do
    it 'does not create a user' do
      post '/api/v0/users/', params: { :user => {} }

      expect(response.status).to eq(422)
      expect(response_json).to have_key('errors')
    end
  end
end