FactoryGirl.define do
  factory :property do
    sequence(:subdomain) { |n| "testproperty#{n}" }
    sequence(:name) { |n| "Test Property #{n}" }
    sequence(:email) { |n| "info@testproperty#{n}.com" }
    time_zone 'Riyadh'
    currency 'BHD'

    trait :with_api_client do
      after(:build) do |property|
        property.api_clients << build(:api_client, property: property)
      end
    end

    factory :property_with_api_client, traits: [:with_api_client]
  end
end