FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john#{n}@example.com" }
    first_name 'John'
    last_name 'Doe'
    password 'secret12345'
    password_confirmation 'secret12345'

    factory :user_with_current_reservation do
      association :reservation, factory: :current_reservation
    end
  end
end
