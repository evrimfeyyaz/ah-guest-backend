FactoryGirl.define do
  factory :room_service_item, class: 'RoomService::Item' do
    sequence(:title) { |n| "Item #{n}" }
    price "9.99"
  end
end
