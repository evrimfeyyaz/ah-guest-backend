FactoryGirl.define do
  factory :room_service_item, class: 'RoomService::Item' do
    sequence(:title) { |n| "Item #{n}" }
    price '9.99'

    association :sub_category, factory: :room_service_sub_category

    factory :room_service_item_with_option do
      after(:create) do |item|
        item.options << create(:room_service_item_choice_with_multiple_options)
      end

      factory :room_service_item_with_option_and_tag do
        after(:create) do |item|
          item.tags << create(:room_service_tag)
        end
      end
    end

    factory :available_room_service_item do
      after(:build) do |item|
        item.sub_category.category.available_from = 1.hour.ago
        item.sub_category.category.available_until = 1.hour.from_now
      end
    end

    factory :unavailable_room_service_item do
      after(:build) do |item|
        item.sub_category.category.available_from = 2.hours.ago
        item.sub_category.category.available_until = 1.hour.ago
      end
    end
  end
end
