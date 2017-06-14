require 'rails_helper'

describe User do
  it { should have_secure_password }
  it { should have_db_column(:auth_token) }
  it { should have_many(:room_service_orders).dependent(:destroy).inverse_of(:user).class_name('RoomService::Order') }
  it { should have_many(:reservations).dependent(:nullify).inverse_of(:user) }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_values('john@example.com',
                           'john.doe@example.com',
                           'j@example.com',
                           'john@example.verylongtld').for(:email) }
  it { should_not allow_values('',
                               '@',
                               '@.',
                               '@example.com',
                               'www.example.com',
                               '.',
                               '.com',
                               'john doe@example.com',
                               'john@example',
                               'john@example.',
                               'john@example.a').for(:email) }

  it { should validate_length_of(:password).is_at_least(8).is_at_most(128).on(:create) }

  it { should validate_presence_of :first_name }
  it { should validate_length_of(:first_name).is_at_most(60) }

  it { should validate_presence_of :last_name }
  it { should validate_length_of(:last_name).is_at_most(60) }

  describe '#current_or_upcoming_reservation' do
    let(:user) { create(:user) }

    context 'when there is a reservation that includes the current day' do
      let!(:reservation) { create(:reservation, check_in_date: 1.day.ago, check_out_date: 1.day.from_now, user: user) }

      context 'and there is a reservation after that' do
        it 'returns the reservation that includes the current day' do
          create(:reservation, check_in_date: 2.days.from_now, check_out_date: 3.days.from_now, user: user)

          user.reload

          expect(user.current_or_upcoming_reservation).to eq(reservation)
        end
      end

      context 'and there is no reservation after that' do
        it 'returns the reservation that includes the current day' do
          expect(user.current_or_upcoming_reservation).to eq(reservation)
        end
      end
    end

    context 'when there is no current reservation but there is an upcoming reservation' do
      it 'returns the nearest upcoming reservation' do
        nearest_upcoming_reservation = create(:reservation, check_in_date: 2.days.from_now,
                                              check_out_date: 3.days.from_now, user: user)
        create(:reservation, check_in_date: 4.days.from_now, check_out_date: 5.days.from_now, user: user)

        user.reload

        expect(user.current_or_upcoming_reservation).to eq(nearest_upcoming_reservation)
      end
    end

    context 'when there is no current or upcoming reservation' do
      context 'and no past reservations' do
        it 'returns nil' do
          expect(user.current_or_upcoming_reservation).to be_nil
        end
      end

      context 'and there are past reservations' do
        it 'returns nil' do
          create(:reservation, check_in_date: 3.days.ago, check_out_date: 2.days.ago, user: user)

          user.reload

          expect(user.current_or_upcoming_reservation).to be_nil
        end
      end
    end
  end

  describe '#current_reservation' do
    let(:user) { create(:user) }

    context 'when there is a reservation that includes the current day' do
      it 'returns the reservation that includes the current day' do
        reservation = create(:reservation, check_in_date: 1.day.ago, check_out_date: 1.day.from_now, user: user)

        user.reload

        expect(user.current_reservation).to eq(reservation)
      end
    end

    context 'when there is no reservation that includes the current day' do
      it 'returns nil' do
        expect(user.current_reservation).to be_nil
      end
    end
  end
end
