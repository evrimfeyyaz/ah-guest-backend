FactoryGirl.define do
  factory :room_service_order, class: 'RoomService::Order' do
    user
    payment_type 0

    transient do
      cart_items_count 2
    end

    after(:build) do |order, evaluator|
      order.reservation = create(:reservation_including_current_day, users: [order.user])
      order.cart_items = build_list(:room_service_cart_item, evaluator.cart_items_count)
    end
  end
end
