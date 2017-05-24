require 'rails_helper'

describe Stay do
  it { should belong_to(:user).inverse_of(:stays) }
  it { should have_many(:room_service_orders).inverse_of(:stay).class_name('RoomService::Order') }

  it { should validate_presence_of :confirmation_code }
  it { should validate_presence_of :check_in_date }
  it { should validate_presence_of :check_out_date }

  context 'when check-in date is after check-out date' do
    it 'should be invalid' do
      check_in_date = Date.strptime('24-05-2017', '%d-%m-%Y')
      check_out_date = check_in_date - 1

      stay = build(:stay, check_in_date: check_in_date, check_out_date: check_out_date)

      expect(stay).not_to be_valid
      expect(stay.errors.details).to include(check_out_date: [{ error: :before_check_in_date }])
    end
  end

  context 'when check-in date and check-out date are the same' do
    it 'should be valid' do
      check_in_date = Date.strptime('24-05-2017', '%d-%m-%Y')
      check_out_date = check_in_date

      stay = build(:stay, check_in_date: check_in_date, check_out_date: check_out_date)

      expect(stay).to be_valid
    end
  end
end