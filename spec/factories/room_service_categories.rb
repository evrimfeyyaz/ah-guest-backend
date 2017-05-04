FactoryGirl.define do
  factory :room_service_category, class: 'RoomService::Category' do
    sequence(:title) { |n| "Category #{n}" }
  end
end
