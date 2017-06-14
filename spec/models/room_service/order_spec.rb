require 'rails_helper'

describe RoomService::Order do
  it { should belong_to(:user).inverse_of(:room_service_orders) }
  it { should belong_to(:reservation).inverse_of(:room_service_orders) }
  it { should have_many(:cart_items).dependent(:destroy).inverse_of(:order).with_foreign_key('room_service_order_id') }

  it 'validates that the reservation belongs to the user' do
    subject.user = create(:user)
    subject.reservation = create(:reservation)

    subject.validate

    expect(subject).not_to be_valid
    expect(subject.errors.details[:reservation]).to include(error: :does_not_belong_to_user)
  end

  it 'validates that the reservation includes the current day' do
    subject.reservation = create(:upcoming_reservation)

    subject.validate

    expect(subject).not_to be_valid
    expect(subject.errors.details[:reservation]).to include(error: :does_not_include_current_day)
  end
end