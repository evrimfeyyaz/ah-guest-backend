FactoryGirl.define do
  factory :reservation do
    sequence(:confirmation_code) { |n| "#{n}" }
    check_in_date 1.day.ago
    check_out_date 1.day.from_now

    factory :upcoming_reservation do
      check_in_date 1.day.from_now
      check_out_date 2.days.from_now
    end
  end
end
