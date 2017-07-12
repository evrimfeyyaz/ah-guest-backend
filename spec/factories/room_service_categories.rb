FactoryGirl.define do
  factory :room_service_category, class: 'RoomService::Category' do
    sequence(:title) { |n| "Category #{n}" }

    factory :room_service_category_with_image do
      image { File.new("#{Rails.root}/spec/support/image.jpg") }
    end
  end
end
