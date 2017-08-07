FactoryGirl.define do
  factory :reservation do
    sequence(:confirmation_code) { |n| "#{n}" }
    check_in_date '2017-01-01'
    check_out_date '2017-01-01'

    trait :including_current_day do
      check_in_date 1.day.ago
      check_out_date 1.day.from_now
    end

    trait :upcoming do
      check_in_date 1.day.from_now
      check_out_date 2.days.from_now
    end

    trait :past do
      check_in_date 2.days.ago
      check_out_date 1.day.ago
    end

    factory :reservation_including_current_day, traits: [:including_current_day]
    factory :upcoming_reservation, traits: [:upcoming]
    factory :past_reservation, traits: [:past]
  end
end
