require 'rails_helper'

describe Reservation do
  it { should have_many(:user_reservation_associations).dependent(:destroy) }
  it { should have_many(:users).inverse_of(:reservations) }
  it { should have_many(:room_service_orders).inverse_of(:reservation).dependent(:destroy) }

  it { should validate_presence_of :confirmation_code }
  it { should validate_uniqueness_of(:confirmation_code).case_insensitive }
  it { should validate_length_of(:confirmation_code).is_at_most(30) }
  it { should validate_presence_of :check_in_date }
  it { should validate_presence_of :check_out_date }
  it { should validate_length_of(:room_number).is_at_most(5) }

  describe 'check-out date is not before check-in date validation' do
    before(:each) do
      subject.check_in_date = Date.today
    end

    context 'when check-in date is after check-out date' do
      it 'should be invalid' do
        subject.check_out_date = subject.check_in_date - 1

        expect(subject).to have_validation_error(:before_check_in_date).on(:check_out_date)
      end
    end

    context 'when check-in date and check-out date are the same' do
      it 'should be valid' do
        subject.check_out_date = subject.check_in_date

        expect(subject).not_to have_validation_error(:before_check_in_date).on(:check_out_date)
      end
    end
  end

  describe '#includes_today?' do
    context 'when the reservation includes the current day' do
      it 'returns true' do
        subject.check_in_date = 1.day.ago
        subject.check_out_date = Date.today

        expect(subject.includes_today?).to be true
      end
    end

    context 'when the reservation does not include the current day' do
      it 'returns false' do
        subject.check_in_date = 2.days.ago
        subject.check_out_date = 1.day.ago

        expect(subject.includes_today?).to be false
      end
    end
  end
end