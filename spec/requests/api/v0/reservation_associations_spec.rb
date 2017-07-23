require 'rails_helper'

describe 'POST /api/v0/users/:user_id/reservation_associations' do
  it_behaves_like 'an endpoint that requires client secret authentication', :post, '/api/v0/users/0/reservation_associations'
  it_behaves_like 'an endpoint that requires user authentication', :post, '/api/v0/users/%{object_id}/reservation_associations' do
    let(:object) { user }
  end

  let(:user) { create(:user) }
  let(:reservation) { create(:reservation, room_number: '1') }

  context 'when the user ID in the URL does not match the current user' do
    it 'responds with "404 Not Found"' do
      wrong_user_id = user.id + 1

      expect {
        post "/api/v0/users/#{wrong_user_id}/reservation_associations", params: {
          'reservation_association' => {
            'reservation_attributes' => {
              'check_in_date' => reservation.check_in_date.iso8601,
              'room_number' => reservation.room_number
            }
          }
        }.to_json, headers: request_headers(user: user)
      }.not_to change { ReservationAssociation.count }

      expect(response.status).to eq(404)
    end
  end

  context 'with check-in date and room number' do
    context 'when the reservation is not associated with a user' do
      it 'associates the found reservation with the current user' do
        post "/api/v0/users/#{user.id}/reservation_associations", params: {
          'reservation_association' => {
            'reservation_attributes' => {
              'check_in_date' => reservation.check_in_date.iso8601,
              'room_number' => reservation.room_number
            }
          }
        }.to_json, headers: request_headers(user: user)

        expect(reservation.users).to include(user)
        expect(response.status).to eq(200)
        expect(response_json).to eq('id' => reservation.reservation_associations.first.id,
                                    'user_id' => user.id,
                                    'reservation' => {
                                      'id' => reservation.id,
                                      'check_in_date' => reservation.check_in_date.iso8601,
                                      'check_out_date' => reservation.check_out_date.iso8601,
                                      'room_number' => reservation.room_number,
                                      'confirmation_code' => reservation.confirmation_code
                                    })
      end

      context 'when the reservation does not have a room number' do
        it 'does not associate a reservation with the current user' do
          reservation.update(room_number: nil)

          post "/api/v0/users/#{user.id}/reservation_associations", params: {
            'reservation_association' => {
              'reservation_attributes' => {
                'check_in_date' => reservation.check_in_date.iso8601,
                'room_number' => nil
              }
            }
          }.to_json, headers: request_headers(user: user)

          expect(reservation.users).not_to include(user)
          expect(response.status).to eq(422)
          expect(response_error).to eq('validation')
        end
      end
    end

    context 'when the reservation is associated with a user' do
      it 'associates the found reservation with the current user while keeping the previous associations' do
        other_user = create(:user)
        reservation.users << other_user

        post "/api/v0/users/#{user.id}/reservation_associations", params: {
          'reservation_association' => {
            'reservation_attributes' => {
              'check_in_date' => reservation.check_in_date.iso8601,
              'room_number' => reservation.room_number
            }
          }
        }.to_json, headers: request_headers(user: user)

        expect(reservation.users).to include(user)
        expect(reservation.users).to include(other_user)
      end
    end

    it 'does not associate a reservation with the current user when the reservation is not found'
  end

  context 'with confirmation code' do
    it 'associates the found reservation with the current user'

    it 'does not associate a reservation with the current user when the reservation is not found'
  end

  context 'with check-in date' do
    context 'when there is only one unassociated reservation that matches the check-in date and the name' do
      it 'associates the reservation with the user and responds with "200 OK"' do
        reservation = create(:reservation, first_name: user.first_name, last_name: user.last_name)

        check_in_date = reservation.check_in_date

        post '/api/v0/reservation_associations', params: {
          'reservation' => {
            'check_in_date' => check_in_date.iso8601
          }
        }.to_json, headers: request_headers(user: user)

        reservation.reload

        expect(reservation.user).to eq(user)
        expect(response.status).to eq(200)
        expect(response_json).to eq('id' => reservation.id,
                                    'check_in_date' => reservation.check_in_date.iso8601,
                                    'check_out_date' => reservation.check_out_date.iso8601,
                                    'first_name' => reservation.first_name,
                                    'last_name' => reservation.last_name,
                                    'room_number' => reservation.room_number,
                                    'confirmation_code' => reservation.confirmation_code)
      end
    end

    context 'when there are multiple unassociated reservations that match the check-in date and the name' do
      it 'does not associate the reservation with the user and responds with "422 Unprocessable Entity"' do
        reservation = create(:reservation, first_name: user.first_name, last_name: user.last_name)

        same_check_in_date = reservation.check_in_date

        create(:reservation, first_name: user.first_name, last_name: user.last_name, check_in_date: same_check_in_date)

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => same_check_in_date.iso8601
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        reservation.reload

        expect(reservation.user).to be_nil
        expect(response.status).to eq(422)
        expect(response_json).to eq('error_type' => 'reservation_association',
                                    'errors' => {
                                      'base' => [
                                        'error' => 'reservation_cannot_be_associated_by_check_in_date',
                                        'full_message' => "Reservation can't be associated by check-in date"
                                      ]
                                    })
      end
    end

    context 'when there is no reservation that matches the check-in date and the name' do
      it 'responds with "422 Unprocessable Entity"' do
        check_in_date = Date.current

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => check_in_date.iso8601
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        expect(response.status).to eq(422)
        expect(response_json).to eq('error_type' => 'reservation_association',
                                    'errors' => {
                                      'base' => [
                                        'error' => 'reservation_cannot_be_associated_by_check_in_date',
                                        'full_message' => "Reservation can't be associated by check-in date"
                                      ]
                                    })
      end
    end

    context 'when there is an associated reservation that matches the check-in date and the name' do
      it 'responds with "422 Unprocessable Entity"' do
        associated_user = create(:user)
        associated_reservation = create(:reservation, user: associated_user)

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => associated_reservation.check_in_date.iso8601
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        expect(response.status).to eq(422)
        expect(response_json).to eq('error_type' => 'reservation_association',
                                    'errors' => {
                                      'base' => [
                                        'error' => 'reservation_cannot_be_associated_by_check_in_date',
                                        'full_message' => "Reservation can't be associated by check-in date"
                                      ]
                                    })
      end
    end

    context 'when there is one reservation that matches the check-in date but not the first name' do
      it 'responds with "422 Unprocessable Entity"' do
        reservation = create(:reservation, first_name: 'Wrong', last_name: user.last_name)

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => reservation.check_in_date.iso8601
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        reservation.reload

        expect(reservation.user).to be_nil
        expect(response.status).to eq(422)
        expect(response_json).to eq('error_type' => 'reservation_association',
                                    'errors' => {
                                      'base' => [
                                        'error' => 'reservation_cannot_be_associated_by_check_in_date',
                                        'full_message' => "Reservation can't be associated by check-in date"
                                      ]
                                    })
      end
    end

    context 'when there is one reservation that matches the check-in date but not the last name' do
      it 'responds with "422 Unprocessable Entity"' do
        reservation = create(:reservation, first_name: user.first_name, last_name: 'Wrong')

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => reservation.check_in_date.iso8601
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        reservation.reload

        expect(reservation.user).to be_nil
        expect(response.status).to eq(422)
        expect(response_json).to eq('error_type' => 'reservation_association',
                                    'errors' => {
                                      'base' => [
                                        'error' => 'reservation_cannot_be_associated_by_check_in_date',
                                        'full_message' => "Reservation can't be associated by check-in date"
                                      ]
                                    })
      end
    end
  end

  context 'with confirmation code' do
    context 'when there is a reservation with the given confirmation code' do
      context 'and it is not associated with a user' do
        it 'associates the reservation with the user and responds with "200 OK"' do
          reservation = create(:reservation)

          expect {
            post '/api/v0/reservation_associations', params: {
              'reservation' => {
                'confirmation_code' => reservation.confirmation_code
              }
            }.to_json, headers: request_headers(user: user)
          }.to change { user.reservations.count }.by(1)

          reservation.reload

          expect(reservation.user).to eq(user)
          expect(response.status).to eq(200)
          expect(response_json).to eq('id' => reservation.id,
                                      'check_in_date' => reservation.check_in_date.iso8601,
                                      'check_out_date' => reservation.check_out_date.iso8601,
                                      'first_name' => reservation.first_name,
                                      'last_name' => reservation.last_name,
                                      'room_number' => reservation.room_number,
                                      'confirmation_code' => reservation.confirmation_code)
        end
      end

      context 'but it is associated with a user' do
        it 'responds with "422 Unprocessable Entity"' do
          another_user = create(:user)
          associated_reservation = create(:reservation, user: another_user)

          expect {
            post '/api/v0/reservation_associations', params: {
              'reservation' => {
                'confirmation_code' => associated_reservation.confirmation_code
              }
            }.to_json, headers: request_headers(user: user)
          }.not_to change { user.reservations.count }

          expect(response.status).to eq(422)
          expect(response_json).to eq('error_type' => 'reservation_association',
                                      'errors' => {
                                        'base' => [
                                          'error' => 'reservation_is_already_associated',
                                          'full_message' => 'The reservation with the given confirmation code is already associated with a user'
                                        ]
                                      })
        end
      end
    end

    context 'when there is no reservation with the given confirmation code' do
      it 'responds with "422 Unprocessable Entity"' do
        wrong_confirmation_code = 'WRONG_CONFIRMATION_CODE'

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'confirmation_code' => wrong_confirmation_code
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        expect(response.status).to eq(422)
        expect(response_json).to eq('error_type' => 'reservation_association',
                                    'errors' => {
                                      'base' => [
                                        'error' => 'reservation_cannot_be_found',
                                        'full_message' => 'No reservation was found for the given confirmation code'
                                      ]
                                    })
      end
    end
  end
end