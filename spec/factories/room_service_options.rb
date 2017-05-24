FactoryGirl.define do
  factory :room_service_option, class: 'RoomService::Option' do
    sequence(:title) { |n| "Item Option #{n}" }
    optional false
    allows_multiple_choices false

    factory :room_service_option_with_choices do
      transient do
        choices_count 2
      end

      after(:create) do |option, evaluator|
        create_list(:room_service_choice, evaluator.choices_count, option: option)
      end
    end
  end
end
