require 'rails_helper'

describe RoomService::Order do
  it { should belong_to(:user).inverse_of(:room_service_orders) }
  it { should belong_to(:reservation).inverse_of(:room_service_orders) }
  it { should have_many(:cart_items).dependent(:destroy).inverse_of(:order).with_foreign_key('room_service_order_id') }
  it { should validate_presence_of :cart_items }
  it { should validate_presence_of :payment_type }

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

  describe '#total' do
    it 'returns the sum total of all cart items' do
      cart_item1 = build(:room_service_cart_item)
      cart_item2 = build(:room_service_cart_item)

      cart_item1.item.price = 1.000
      cart_item2.item.price = 2.000
      cart_item2.quantity = 2

      subject.cart_items << [cart_item1, cart_item2]

      expect(subject.total).to eq(5.000)
    end
  end

  describe '#completed?' do
    it 'returns true when completed' do
      subject.status = 1

      expect(subject.completed?).to eq(true)
    end

    it 'returns false when not completed' do
      subject.status = 0

      expect(subject.completed?).to eq(false)
    end
  end
end