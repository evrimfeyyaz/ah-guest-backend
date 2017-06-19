FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password 'secret12345'
    password_confirmation 'secret12345'
    confirmed_at Date.current
  end
end
