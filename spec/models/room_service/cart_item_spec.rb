require 'rails_helper'

describe RoomService::CartItem do
  it { should belong_to(:order).inverse_of(:cart_items).with_foreign_key('room_service_order_id') }
  it { should belong_to(:item).with_foreign_key('room_service_item_id') }
  it { should have_many(:choices_for_options).with_foreign_key('room_service_cart_item_id') }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }
end