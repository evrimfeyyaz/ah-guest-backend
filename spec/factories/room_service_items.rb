FactoryGirl.define do
  factory :room_service_item, class: 'RoomService::Item' do
    sequence(:title) { |n| "Item #{n}" }
    price '9.99'

    association :section, factory: :room_service_section

    factory :room_service_item_with_option do
      after(:create) do |item|
        item.options << create(:room_service_option_with_choices)
      end
    end

    factory :available_room_service_item do
      after(:build) do |item|
        item.section.category.available_from = 1.hour.ago
        item.section.category.available_until = 1.hour.from_now
      end
    end

    factory :unavailable_room_service_item do
      after(:build) do |item|
        item.section.category.available_from = 2.hours.ago
        item.section.category.available_until = 1.hour.ago
      end
    end
  end
end
