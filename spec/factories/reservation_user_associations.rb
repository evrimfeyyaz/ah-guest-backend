FactoryGirl.define do
  factory :reservation_user_association, class: 'Reservation::UserAssociation' do
    association :reservation, factory: :reservation
    association :user, factory: :user
  end
end