FactoryGirl.define do
  factory :room_service_item_option_choice, class: 'RoomService::ItemOptionChoice' do
    sequence(:title) { |n| "Item Option Choice #{n}" }
    price "9.99"
  end
end
