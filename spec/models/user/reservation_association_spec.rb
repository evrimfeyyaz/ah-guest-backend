require 'rails_helper'

describe User::ReservationAssociation do
  it { should belong_to :user }
  it { should belong_to :reservation }

  it {
    subject = create(:user_reservation_association)
    should validate_uniqueness_of(:reservation).scoped_to(:user_id)
  }
end