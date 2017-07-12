FactoryGirl.define do
  factory :room_service_order, class: 'RoomService::Order' do
    user

    transient do
      cart_items_count 2
    end

    before(:create) do |order, evaluator|
      order.cart_items = build_list(:room_service_cart_item, evaluator.cart_items_count)
      order.reservation = create(:reservation_including_current_day, user: order.user)
    end
  end
end
