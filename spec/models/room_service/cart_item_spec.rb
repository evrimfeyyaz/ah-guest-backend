require 'rails_helper'

describe RoomService::CartItem do
  it { should belong_to(:order).inverse_of(:cart_items).with_foreign_key('room_service_order_id') }
  it { should belong_to(:item).with_foreign_key('room_service_item_id') }
  it { should have_many(:choices_for_options).with_foreign_key('room_service_cart_item_id') }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe 'validates availability of the item' do
    context 'when item is available' do
      it 'does not have a validation error' do
        subject.item = build(:available_room_service_item)

        subject.validate

        expect(subject.errors[:base]).not_to include("\"#{subject.item.title}\" is not available at the moment")
      end
    end

    context 'when item is not available' do
      it 'has a validation error' do
        subject.item = build(:unavailable_room_service_item)

        subject.validate

        expect(subject.errors[:base]).to include("\"#{subject.item.title}\" is not available at the moment (only available from #{subject.item.available_from.strftime('%H:%M')} to #{subject.item.available_until.strftime('%H:%M')})")
      end
    end
  end
end