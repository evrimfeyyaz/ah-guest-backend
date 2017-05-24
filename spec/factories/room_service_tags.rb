FactoryGirl.define do
  factory :room_service_tag, class: 'RoomService::Tag' do
    sequence(:title) { |n| "Tag #{n}" }
  end
end