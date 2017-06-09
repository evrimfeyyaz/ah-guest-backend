FactoryGirl.define do
  factory :room_service_choices_for_option, class: 'RoomService::ChoicesForOption' do
    association :option, factory: :room_service_option
    association :cart_item, factory: :room_service_cart_item
  end
end
