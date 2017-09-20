FactoryGirl.define do
  factory :room_service_category, class: 'RoomService::Category' do
    sequence(:title) { |n| "Category #{n}" }

    trait :with_image do
      image { File.new("#{Rails.root}/spec/support/image.jpg") }
    end

    trait :with_items_in_default_section do
      transient do
        items_count 2
      end

      after(:create) do |category, evaluator|
        section = category.default_section
        section.items << create_list(:room_service_item, evaluator.items_count, category_section: section)
      end
    end

    factory :room_service_category_with_image, traits: [:with_image]
    factory :room_service_category_with_items_in_default_section, traits: [:with_items_in_default_section]
  end
end