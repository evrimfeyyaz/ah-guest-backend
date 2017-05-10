FactoryGirl.define do
  factory :room_service_item_attribute, class: 'RoomService::ItemAttribute' do
    sequence(:title) { |n| "Item Attribute #{n}" }
  end
end
