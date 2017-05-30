FactoryGirl.define do
  factory :room_service_cart_item, class: 'RoomService::CartItem' do
    quantity 1

    association :item, factory: :room_service_item
  end
end
