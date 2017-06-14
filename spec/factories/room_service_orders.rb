FactoryGirl.define do
  factory :room_service_order, class: 'RoomService::Order' do
    user
    association :reservation, factory: :reservation_including_current_day

    transient do
      cart_items_count 2
    end

    before(:create) do |order, evaluator|
      order.cart_items = build_list(:room_service_cart_item, evaluator.cart_items_count)
    end
  end
end
