FactoryGirl.define do
  factory :room_service_item_choice, class: 'RoomService::ItemChoice' do
    sequence(:title) { |n| "Choice #{n}" }

    trait :optional do
      optional true
    end

    trait :non_optional do
      optional false
    end

    trait :single_option do
      allows_multiple_options false
    end

    trait :multiple_option do
      allows_multiple_options true
    end

    factory :optional_room_service_item_choice, traits: [:optional]
    factory :non_optional_room_service_item_choice, traits: [:non_optional]
    factory :single_option_room_service_item_choice, traits: [:single_option]
    factory :multiple_option_room_service_item_choice, traits: [:multiple_option]

    factory :room_service_item_choice_with_options do
      transient do
        options_count 2
      end

      before(:create) do |choice, evaluator|
        choice.options = build_list(:room_service_item_choice_option, evaluator.options_count)
      end
    end
  end
end
