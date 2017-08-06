FactoryGirl.define do
  factory :room_service_category, class: 'RoomService::Category' do
    sequence(:title) { |n| "Category #{n}" }

    trait :with_image do
      image { File.new("#{Rails.root}/spec/support/image.jpg") }
    end

    factory :room_service_category_with_image, traits: [:with_image]
  end
end
