require 'rails_helper'

describe 'POST /api/v0/users/' do
  context 'with invalid client key' do
    it 'returns "401 Unauthorized"' do
      post '/api/v0/users/', headers: headers('INVALID_CLIENT_KEY')

      expect(response.status).to eq(401)
    end
  end

  context 'with valid client key' do
    let(:client_key) { Rails.application.secrets.client_key }

    context 'and valid parameters' do
      it 'creates a user' do
        user_attributes = attributes_for(:user)

        post '/api/v0/users/', params: {
          'user' => {
            'first_name' => user_attributes[:first_name],
            'last_name' => user_attributes[:last_name],
            'email' => user_attributes[:email],
            'password' => user_attributes[:password],
            'password_confirmation' => user_attributes[:password]
          }
        }.to_json, headers: headers(client_key)

        user = User.find_by(email: user_attributes[:email])

        expect(response.status).to eq(201)
        expect(response_json).to eq('id' => user.id,
                                    'email' => user.email,
                                    'first_name' => user.first_name,
                                    'last_name' => user.last_name,
                                    'auth_token_with_id' => user.auth_token_with_id)
      end
    end

    context 'and invalid parameters' do
      it 'does not create a user' do
        post '/api/v0/users/', params: {
          'user' => {
            'first_name' => '',
            'last_name' => '',
            'email' => '',
            'password' => '',
            'password_confirmation' => ''
          }
        }.to_json, headers: headers(client_key)

        expect(response.status).to eq(422)
        expect(response_json).to have_key('errors')
      end
    end
  end
end