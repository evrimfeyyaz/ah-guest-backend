FactoryGirl.define do
  factory :room_service_sub_category, class: 'RoomService::SubCategory' do
    sequence(:title) { |n| "Sub-Category #{n}" }

    association :category, factory: :room_service_category
  end
end
