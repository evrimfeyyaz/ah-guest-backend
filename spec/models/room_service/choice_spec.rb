require 'rails_helper'

describe RoomService::Choice do
  it { should belong_to(:option).inverse_of(:possible_choices).with_foreign_key('room_service_option_id') }

  it { should validate_presence_of :title }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end
