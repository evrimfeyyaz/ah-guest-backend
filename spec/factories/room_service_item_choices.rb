FactoryGirl.define do
  factory :room_service_item_choice, class: 'RoomService::ItemChoice' do
    sequence(:title) { |n| "Choice #{n}" }
    optional false
    allows_multiple_options false

    factory :room_service_item_choice_with_options do
      transient do
        options_count 2
      end

      after(:create) do |choice, evaluator|
        create_list(:room_service_item_choice_option, evaluator.options_count, choice: choice)
      end
    end

    trait :optional do
      optional true
    end

    trait :single_option do
      allows_multiple_options false
    end

    trait :multiple_option do
      allows_multiple_options true
    end
  end
end
