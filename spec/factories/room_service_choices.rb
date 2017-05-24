FactoryGirl.define do
  factory :room_service_choice, class: 'RoomService::Choice' do
    sequence(:title) { |n| "Choice #{n}" }
    price '9.99'
  end
end
