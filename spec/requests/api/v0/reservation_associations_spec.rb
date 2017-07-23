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

    it 'does not associate a reservation with the current user when the reservation is not found' do
      wrong_date = reservation.check_in_date + 1.day

      expect {
        post "/api/v0/users/#{user.id}/reservation_associations", params: {
          'reservation_association' => {
            'reservation_attributes' => {
              'check_in_date' => wrong_date.iso8601,
              'room_number' => reservation.room_number
            }
          }
        }.to_json, headers: request_headers(user: user)
      }.not_to change { ReservationAssociation.count }
    end
  end

  context 'with confirmation code' do
    it 'associates the found reservation with the current user' do
      post "/api/v0/users/#{user.id}/reservation_associations", params: {
        'reservation_association' => {
          'reservation_attributes' => {
            'confirmation_code' => reservation.confirmation_code
          }
        }
      }.to_json, headers: request_headers(user: user)

      expect(reservation.users).to include(user)
    end

    it 'does not associate a reservation with the current user when the reservation is not found' do
      wrong_confirmation_code = 'WRONG'

      expect {
        post "/api/v0/users/#{user.id}/reservation_associations", params: {
          'reservation_association' => {
            'reservation_attributes' => {
              'confirmation_code' => wrong_confirmation_code
            }
          }
        }.to_json, headers: request_headers(user: user)
      }.not_to change { ReservationAssociation.count }
    end
  end
end