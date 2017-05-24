FactoryGirl.define do
  factory :room_service_choices_for_option, class: 'RoomService::ChoicesForOption' do
    option nil
    number_of_possible_choices 1
  end
end
