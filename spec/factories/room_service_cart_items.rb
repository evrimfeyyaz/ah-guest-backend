FactoryGirl.define do
  factory :room_service_cart_item, class: 'RoomService::CartItem' do
    quantity 1

    association :item, factory: :room_service_item

    after(:build) do |cart_item|
      cart_item.order = build(:room_service_order, cart_items_count: 0)
    end

    trait :with_multiple_option_choice do
      association :item, factory: :room_service_item_with_multiple_option_choice
    end
  end
end
