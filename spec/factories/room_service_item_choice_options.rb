FactoryGirl.define do
  factory :room_service_item_choice_option, class: 'RoomService::ItemChoiceOption' do
    sequence(:title) { |n| "Option #{n}" }
    price '9.99'
  end
end
