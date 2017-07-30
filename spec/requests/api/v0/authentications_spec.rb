require 'rails_helper'

describe 'POST /api/v0/authentication/' do
  it_behaves_like 'an endpoint that requires client secret authentication', :post, '/api/v0/authentication/'

  context 'with valid credentials' do
    it 'returns a user' do
      user = create(:user)
      reservation = create(:reservation,
                           users: [user],
                           check_in_date: 1.day.ago,
                           check_out_date: 1.day.from_now,
                           first_name: user.first_name,
                           last_name: user.last_name)

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
                                  'auth_token' => user.auth_token,
                                  'current_or_upcoming_reservation' => {
                                    'id' => reservation.id,
                                    'check_in_date' => reservation.check_in_date.to_s,
                                    'check_out_date' => reservation.check_out_date.to_s,
                                    'first_name' => reservation.first_name,
                                    'last_name' => reservation.last_name,
                                    'confirmation_code' => reservation.confirmation_code,
                                    'room_number' => reservation.room_number
                                  })
    end
  end

  context 'with invalid password' do
    it 'responds with "401 Unauthorized"' do
      user = create(:user)

      post '/api/v0/authentication/', params: {
        'user' => {
          'email' => user.email,
          'password' => 'wrong_password'
        }
      }.to_json, headers: request_headers

      expect(response.status).to eq(401)
      expect(response.body).to be_empty
    end
  end

  context 'when user does not exist' do
    it 'responds with "401 Unauthorized"' do
      post '/api/v0/authentication/', params: {
        'user' => {
          'email' => 'wrong@email.com',
          'password' => 'IRRELEVANT'
        }
      }.to_json, headers: request_headers

      expect(response.status).to eq(401)
      expect(response.body).to be_empty
    end
  end
end

describe 'DELETE /api/v0/authentication' do
  it_behaves_like 'an endpoint that requires client secret authentication', :delete, '/api/v0/authentication/'
  it_behaves_like 'an endpoint that requires user authentication', :delete, '/api/v0/authentication'

  it 'resets the authentication token of the current user and responds with "204 No Content"' do
    user = create(:user)
    signed_in_authentication_token = user.auth_token

    delete '/api/v0/authentication/', headers: request_headers(user: user)

    user.reload

    expect(response.status).to eq(204)
    expect(user.auth_token).not_to be_nil
    expect(user.auth_token).not_to eq(signed_in_authentication_token)
  end
end