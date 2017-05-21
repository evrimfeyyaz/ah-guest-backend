FactoryGirl.define do
  factory :room_service_section, class: 'RoomService::Section' do
    sequence(:title) { |n| "Section #{n}" }

    association :category, factory: :room_service_category
  end
end
