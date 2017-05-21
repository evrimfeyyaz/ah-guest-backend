require 'rails_helper'

describe RoomService::Order, 'Validations' do
  it { should have_many(:cart_items).with_foreign_key('room_service_order_id') }
end
