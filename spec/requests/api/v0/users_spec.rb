require 'rails_helper'

describe 'POST /api/v0/users/' do
  it_behaves_like 'an endpoint that requires client secret authentication', :post, '/api/v0/users/'

  context 'with valid parameters' do
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
      }.to_json, headers: request_headers

      user = User.find_by(email: user_attributes[:email])

      expect(response.status).to eq(201)
      expect(response_json).to eq('id' => user.id,
                                  'email' => user.email,
                                  'first_name' => user.first_name,
                                  'last_name' => user.last_name,
                                  'auth_token' => user.auth_token,
                                  'current_or_upcoming_reservation' => nil)
    end
  end

  context 'with invalid parameters' do
    it 'does not create a user' do
      post '/api/v0/users/', params: {
        'user' => {
          'first_name' => '',
          'last_name' => '',
          'email' => '',
          'password' => '',
          'password_confirmation' => ''
        }
      }.to_json, headers: request_headers

      expect(response.status).to eq(422)
      expect(response_json).to include('error_type' => 'validation')
      expect(response_json).to have_key('errors')
    end
  end
end