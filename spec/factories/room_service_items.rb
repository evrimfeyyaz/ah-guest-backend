FactoryGirl.define do
  factory :room_service_item, class: 'RoomService::Item' do
    sequence(:title) { |n| "Item #{n}" }
    price '9.99'

    association :section, factory: :room_service_section

    factory :room_service_item_with_option do
      after(:create) do |item|
        item.options << create(:room_service_option_with_choices)
      end
    end
  end
end
