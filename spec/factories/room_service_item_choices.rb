FactoryGirl.define do
  factory :room_service_item_choice, class: 'RoomService::Item::Choice' do
    sequence(:title) { |n| "Choice #{n}" }

    transient do
      options_count 2
    end

    after(:build) do |choice, evaluator|
      choice.options = build_list(:room_service_item_choice_option, evaluator.options_count, choice: choice)
    end

      trait :optional do
      optional true
    end

    trait :mandatory do
      optional false
    end

    trait :single_option do
      allows_multiple_options false
    end

    trait :multiple_option do
      allows_multiple_options true
    end

    factory :optional_room_service_item_choice, traits: [:optional]
    factory :non_optional_room_service_item_choice, traits: [:mandatory]
    factory :single_option_room_service_item_choice, traits: [:single_option]
    factory :multiple_option_room_service_item_choice, traits: [:multiple_option]
  end
end
