FactoryGirl.define do
  factory :user_reservation_association, class: 'User::ReservationAssociation' do
    association :reservation, factory: :reservation
    association :user, factory: :user
  end
end