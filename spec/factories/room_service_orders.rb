FactoryGirl.define do
  factory :room_service_order, class: 'RoomService::Order' do
    user
    reservation
    association :cart_items, factory: :room_service_cart_items
  end
end
