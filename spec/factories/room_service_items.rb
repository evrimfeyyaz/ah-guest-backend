FactoryGirl.define do
  factory :room_service_item, class: 'RoomService::Item' do
    sequence(:title) { |n| "Item #{n}" }
    price '9.99'

    association :category_section, factory: :room_service_category_section

    trait :with_mandatory_choice do
      after(:build) do |item|
        item.choices << create(:room_service_item_choice, :mandatory)
      end
    end

    trait :with_optional_choice do
      after(:build) do |item|
        item.choices << create(:room_service_item_choice, :optional)
      end
    end

    trait :with_tag do
      after(:build) do |item|
        item.tags << create(:room_service_tag)
      end
    end

    trait :with_single_option_choice do
      after(:build) do |item|
        item.choices << create(:room_service_item_choice, :single_option)
      end
    end

    trait :with_multiple_option_choice do
      after(:build) do |item|
        item.choices << create(:room_service_item_choice, :multiple_option)
      end
    end

    trait :available do
      after(:build) do |item|
        item.category_section.category.available_from = 1.hour.ago
        item.category_section.category.available_until = 1.hour.from_now
      end
    end

    trait :unavailable do
      after(:build) do |item|
        item.category_section.category.available_from = 2.hours.ago
        item.category_section.category.available_until = 1.hour.ago
      end
    end

    factory :room_service_item_with_mandatory_choice, traits: [:with_mandatory_choice]
    factory :room_service_item_with_optional_choice, traits: [:with_optional_choice]
    factory :room_service_item_with_choice_and_tag, traits: [:with_optional_choice, :with_tag]
    factory :room_service_item_with_single_option_choice, traits: [:with_single_option_choice]
    factory :room_service_item_with_multiple_option_choice, traits: [:with_multiple_option_choice]
    factory :available_room_service_item, traits: [:available]
    factory :unavailable_room_service_item, traits: [:unavailable]
  end
end
