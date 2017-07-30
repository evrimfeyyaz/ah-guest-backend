require 'rails_helper'

describe ReservationAssociation do
  it { should belong_to :user }
  it { should belong_to :reservation }
end