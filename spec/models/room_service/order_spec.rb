require 'rails_helper'

describe RoomService::Order do
  it { should belong_to(:user).inverse_of(:room_service_orders) }
  it { should belong_to(:reservation).inverse_of(:room_service_orders) }
  it { should have_many(:cart_items).dependent(:destroy).inverse_of(:order) }

  it { should validate_presence_of :cart_items }
  it { should validate_presence_of :payment_type }
  it { should validate_presence_of :status }

  it { should accept_nested_attributes_for(:cart_items) }

  describe 'reservation belongs to user validation' do
    let (:user) { build(:user) }
    let (:reservation) { build(:reservation) }

    it 'does not add a validation error when the reservation belongs to the user' do
      subject.user = user
      subject.reservation = reservation
      user.reservations << reservation

      expect(subject).not_to have_validation_error(:does_not_belong_to_user).on(:reservation)
    end

    it 'adds a validation error when the reservation does not belong to the user' do
      subject.user = user
      subject.reservation = reservation

      expect(subject).to have_validation_error(:does_not_belong_to_user).on(:reservation)
    end

    it 'does not add a validation error when the user is nil' do
      subject.user = nil
      subject.reservation = reservation

      expect(subject).not_to have_validation_error(:does_not_belong_to_user).on(:reservation)
    end

    it 'does not add a validation error when the reservation is nil' do
      subject.user = user
      subject.reservation = nil

      expect(subject).not_to have_validation_error(:does_not_belong_to_user).on(:reservation)
    end
  end

  describe 'reservation includes current day validation' do
    it 'does not add a validation error when the reservation includes the current day' do
      subject.reservation = build(:reservation_including_current_day)

      expect(subject).not_to have_validation_error(:does_not_include_current_day).on(:reservation)
    end

    it 'adds a validation error when the reservation does not include the current day' do
      subject.reservation = build(:upcoming_reservation)

      expect(subject).to have_validation_error(:does_not_include_current_day).on(:reservation)
    end

    it 'does not add a validation error when the reservation is nil' do
      subject.reservation = nil

      expect(subject).not_to have_validation_error(:does_not_include_current_day).on(:reservation)
    end
  end

  describe '#total' do
    it 'returns the sum total of all cart items in the order' do
      cart_item1 = build(:room_service_cart_item)
      cart_item2 = build(:room_service_cart_item)

      cart_item1.item.price = 1.000
      cart_item2.item.price = 2.000
      cart_item2.quantity = 2

      subject.cart_items << [cart_item1, cart_item2]

      expect(subject.total).to eq(5.000)
    end
  end
end