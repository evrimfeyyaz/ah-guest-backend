FactoryGirl.define do
  factory :room_service_item_tag_association, class: 'RoomService::Item::TagAssociation' do
    association :item, factory: :room_service_item
    association :tag, factory: :room_service_tag
  end
end