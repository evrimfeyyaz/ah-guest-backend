FactoryGirl.define do
  factory :room_service_order, class: 'RoomService::Order' do
    user
    association :cart_items, factory: :room_service_cart_items
  end
end
