require 'rails_helper'

describe 'POST /api/v0/reservation_associations' do
  it_behaves_like 'an endpoint that requires client secret authentication', :post, '/api/v0/reservation_associations'
  it_behaves_like 'an endpoint that requires user authentication', :post, '/api/v0/reservation_associations'

  let(:user) { create(:user) }

  context 'with check-in date' do
    context 'when there is only one unassociated reservation that matches the check-in date and the name' do
      it 'associates the reservation with the user and responds with "204 No Content"' do
        reservation = create(:reservation, first_name: user.first_name, last_name: user.last_name)

        check_in_date = reservation.check_in_date

        post '/api/v0/reservation_associations', params: {
          'reservation' => {
            'check_in_date' => check_in_date
          }
        }.to_json, headers: request_headers(user: user)

        reservation.reload

        expect(reservation.user).to eq(user)
        expect(response.status).to eq(204)
      end
    end

    context 'when there are multiple unassociated reservations that match the check-in date and the name' do
      it 'does not associate the reservation with the user and responds with "400 Bad Request"' do
        reservation = create(:reservation, first_name: user.first_name, last_name: user.last_name)

        same_check_in_date = reservation.check_in_date

        create(:reservation, first_name: user.first_name, last_name: user.last_name, check_in_date: same_check_in_date)

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => same_check_in_date
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        reservation.reload

        expect(reservation.user).to be_nil
        expect(response.status).to eq(400)
      end
    end

    context 'when there is no reservation that matches the check-in date and the name' do
      it 'responds with "400 Bad Request"' do
        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => Date.current
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        expect(response.status).to eq(400)
      end
    end

    context 'when there is an associated reservation that matches the check-in date and the name' do
      it 'responds with "400 Bad Request"' do
        associated_user = create(:user)
        associated_reservation = create(:reservation, user: associated_user)

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => associated_reservation.check_in_date
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        expect(response.status).to eq(400)
      end
    end

    context 'when there is one reservation that matches the check-in date but not the first name' do
      it 'responds with "400 Bad Request"' do
        reservation = create(:reservation, first_name: 'Wrong', last_name: user.last_name)

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => reservation.check_in_date
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        reservation.reload

        expect(reservation.user).to be_nil
        expect(response.status).to eq(400)
      end
    end

    context 'when there is one reservation that matches the check-in date but not the last name' do
      it 'responds with "400 Bad Request"' do
        reservation = create(:reservation, first_name: user.first_name, last_name: 'Wrong')

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'check_in_date' => reservation.check_in_date
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        reservation.reload

        expect(reservation.user).to be_nil
        expect(response.status).to eq(400)
      end
    end
  end

  context 'with confirmation code' do
    context 'when there is a reservation with the given confirmation code' do
      it 'associates the reservation with the user and responds with "204 No Content"' do
        reservation = create(:reservation)

        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'confirmation_code' => reservation.confirmation_code
            }
          }.to_json, headers: request_headers(user: user)
        }.to change { user.reservations.count }.by(1)

        reservation.reload

        expect(response.status).to eq(204)
        expect(reservation.user).to eq(user)
      end
    end

    context 'when there is no reservation with the given confirmation code' do
      it 'responds with "400 Bad Request"' do
        expect {
          post '/api/v0/reservation_associations', params: {
            'reservation' => {
              'confirmation_code' => 'WRONG_CONFIRMATION_CODE'
            }
          }.to_json, headers: request_headers(user: user)
        }.not_to change { user.reservations.count }

        expect(response.status).to eq(400)
      end
    end
  end
end