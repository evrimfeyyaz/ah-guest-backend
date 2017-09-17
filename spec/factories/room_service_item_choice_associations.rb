FactoryGirl.define do
  factory :room_service_item_choice_association, class: 'RoomService::Item::ChoiceAssociation' do
    association :item, factory: :room_service_item
    association :choice, factory: :room_service_item_choice
  end
end
