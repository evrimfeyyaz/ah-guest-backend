require 'rails_helper'

describe Reservation::UserAssociation do
  it { should belong_to :user }
  it { should belong_to :reservation }

  it {
    subject = create(:reservation_user_association)
    should validate_uniqueness_of(:reservation).scoped_to(:user_id)
  }
end