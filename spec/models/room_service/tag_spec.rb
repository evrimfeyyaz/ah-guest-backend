require 'rails_helper'

describe RoomService::Tag do
  it { should have_and_belong_to_many(:items).
    join_table('room_service_items_room_service_tags').
    inverse_of(:tags) }

  it { should validate_presence_of :title }
end
