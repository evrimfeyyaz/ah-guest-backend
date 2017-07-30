require 'rails_helper'

describe Reservation do
  it { should have_many :reservation_associations }
  it { should have_many(:users).inverse_of(:reservations) }
  it { should have_many(:room_service_orders).inverse_of(:reservation).class_name('RoomService::Order').dependent(:destroy) }

  it { should validate_presence_of :confirmation_code }
  it { should validate_uniqueness_of(:confirmation_code).case_insensitive }
  it { should validate_presence_of :check_in_date }
  it { should validate_presence_of :check_out_date }

  context 'when check-in date is after check-out date' do
    it 'should be invalid' do
      check_in_date = Date.strptime('24-05-2017', '%d-%m-%Y')
      check_out_date = check_in_date - 1

      reservation = build(:reservation, check_in_date: check_in_date, check_out_date: check_out_date)

      expect(reservation).not_to be_valid
      expect(reservation.errors.details).to include(check_out_date: [{ error: :before_check_in_date }])
    end
  end

  context 'when check-in date and check-out date are the same' do
    it 'should be valid' do
      check_in_date = Date.strptime('24-05-2017', '%d-%m-%Y')
      check_out_date = check_in_date

      reservation = build(:reservation, check_in_date: check_in_date, check_out_date: check_out_date)

      expect(reservation).to be_valid
    end
  end

  context '#includes_current_day?' do
    it 'returns true when the reservation includes the current day' do
      subject.check_in_date = 1.day.ago
      subject.check_out_date = Date.current

      expect(subject.includes_current_day?).to be true
    end

    it 'returns false when the reservation does not include the current day' do
      subject.check_in_date = 2.days.ago
      subject.check_out_date = 1.day.ago

      expect(subject.includes_current_day?).to be false
    end
  end
end