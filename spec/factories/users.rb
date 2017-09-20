FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john#{n}@example.com" }
    first_name 'John'
    last_name 'Doe'
    password '12345678'
    password_confirmation '12345678'

    trait :with_reservation_including_current_day do
      after(:build) do |user|
        user.reservations << build(:reservation_including_current_day)
      end
    end

    factory :user_with_reservation_including_current_day, traits: [:with_reservation_including_current_day]
  end
end
