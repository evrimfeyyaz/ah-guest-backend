FactoryGirl.define do
  factory :api_client do
    sequence(:name) { |n| "Test Client #{n}" }
    sequence(:secret) { |n| "test_secret_#{n}" }
    property
  end
end
