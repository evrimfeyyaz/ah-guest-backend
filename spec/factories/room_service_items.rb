FactoryGirl.define do
  factory :room_service_item, class: 'RoomService::Item' do
    sequence(:title) { |n| "Item #{n}" }
    price '9.99'

    association :category_section, factory: :room_service_category_section

    factory :room_service_item_with_non_optional_choice do
      after(:create) do |item|
        item.choices << create(:room_service_item_choice_with_options, :non_optional)
      end
    end

    factory :room_service_item_with_optional_choice do
      after(:create) do |item|
        item.choices << create(:room_service_item_choice_with_options, :optional)
      end

      factory :room_service_item_with_choice_and_tag do
        after(:create) do |item|
          item.tags << create(:room_service_tag)
        end
      end
    end

    factory :room_service_item_with_single_option_choice do
      after(:create) do |item|
        item.choices << create(:room_service_item_choice_with_options, :single_option)
      end
    end

    factory :room_service_item_with_multiple_option_choice do
      after(:create) do |item|
        item.choices << create(:room_service_item_choice_with_options, :multiple_option)
      end
    end

    factory :available_room_service_item do
      after(:build) do |item|
        item.category_section.category.available_from = 1.hour.ago
        item.category_section.category.available_until = 1.hour.from_now
      end
    end

    factory :unavailable_room_service_item do
      after(:build) do |item|
        item.category_section.category.available_from = 2.hours.ago
        item.category_section.category.available_until = 1.hour.ago
      end
    end
  end
end
