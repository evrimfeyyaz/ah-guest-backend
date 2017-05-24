require 'rails_helper'

describe RoomService::ItemAttribute do
  it { should have_and_belong_to_many(:items).
    join_table('room_service_items_room_service_item_attributes').
    inverse_of(:item_attributes) }

  it { should validate_presence_of :title }
end
