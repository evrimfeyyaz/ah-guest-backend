FactoryGirl.define do
  factory :room_service_category_section, class: 'RoomService::Category::Section' do
    sequence(:title) { |n| "Sub-Category #{n}" }

    association :category, factory: :room_service_category
  end
end
