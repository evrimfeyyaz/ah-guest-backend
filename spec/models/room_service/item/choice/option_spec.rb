require 'rails_helper'

describe RoomService::Item::Choice::Option do
  it { should belong_to(:choice).inverse_of(:options) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end
