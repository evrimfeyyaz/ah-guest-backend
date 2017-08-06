FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john#{n}@example.com" }
    first_name 'John'
    last_name 'Doe'
    password '12345678'
    password_confirmation '12345678'

    factory :user_with_current_reservation do
      association :reservation, factory: :current_reservation
    end
  end
end
