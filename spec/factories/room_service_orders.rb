FactoryGirl.define do
  factory :room_service_order, class: 'RoomService::Order' do
    user

    after(:build) do |order|
      order.reservation = create(:reservation, user: order.user)
    end

    factory :room_service_order_with_cart_items do
      transient do
        cart_items_count 2
      end

      after(:create) do |order, evaluator|
        create_list(:room_service_cart_item, evaluator.cart_items_count, order: order)
      end
    end
  end
end
