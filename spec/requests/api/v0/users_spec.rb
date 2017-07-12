require 'rails_helper'

describe 'GET /api/v0/users/:id' do
  it_behaves_like 'an endpoint that requires client secret authentication', :get, '/api/v0/users/0'
  it_behaves_like 'an endpoint that requires user authentication', :get, '/api/v0/users/0'

  let(:user) { create(:user) }

  context 'when the current user tries to access their own user details' do
    it 'returns the user object and responds with "200 OK"' do
      user.reservations.create(attributes_for(:upcoming_reservation))

      get "/api/v0/users/#{user.id}", headers: request_headers(user: user)

      expect(response.status).to eq(200)
      expect(response_json).to eq('id' => user.id,
                                  'first_name' => user.first_name,
                                  'last_name' => user.last_name,
                                  'email' => user.email,
                                  'auth_token' => user.auth_token,
                                  'current_or_upcoming_reservation' => {
                                    'id' => user.current_or_upcoming_reservation.id,
                                    'check_in_date' => user.current_or_upcoming_reservation.check_in_date.iso8601,
                                    'check_out_date' => user.current_or_upcoming_reservation.check_out_date.iso8601,
                                    'first_name' => user.current_or_upcoming_reservation.first_name,
                                    'last_name' => user.current_or_upcoming_reservation.last_name,
                                    'room_number' => user.current_or_upcoming_reservation.room_number,
                                    'confirmation_code' => user.current_or_upcoming_reservation.confirmation_code })
    end
  end

  context 'when the current user tries to access details of another user' do
    it 'responds with "404 Not Found"' do
      another_user = create(:user)

      get "/api/v0/users/#{another_user.id}", headers: request_headers(user: user)

      expect(response.status).to eq(404)
    end
  end

  context 'when no user exists for the given ID' do
    it 'responds with "404 Not Found"' do
      wrong_user_id = user.id + 1

      get "/api/v0/users/#{wrong_user_id}", headers: request_headers(user: user)

      expect(response.status).to eq(404)
    end
  end
end

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
    # TODO: Decide on a format for naming test methods, should I explain what I expect to happen or what response should be returned or both?
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
    end
  end
end