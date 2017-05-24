require 'rails_helper'

describe RoomService::Order do
  it { should belong_to(:user).inverse_of(:room_service_orders) }
  it { should belong_to(:stay).inverse_of(:room_service_orders) }
  it { should have_many(:cart_items).dependent(:destroy).inverse_of(:order).with_foreign_key('room_service_order_id') }
end