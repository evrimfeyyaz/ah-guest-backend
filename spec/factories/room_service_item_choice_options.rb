FactoryGirl.define do
  factory :room_service_item_choice_option, class: 'RoomService::Item::Choice::Option' do
    association :choice, factory: :room_service_item_choice
    sequence(:title) { |n| "Option #{n}" }
    price '9.99'
  end
end