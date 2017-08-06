FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password '123456'
    confirmed_at Date.current
  end
end
