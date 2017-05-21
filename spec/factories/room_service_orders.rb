FactoryGirl.define do
  factory :room_service_order, class: 'RoomService::Order' do
    room_service_cart_items ""
  end
end
