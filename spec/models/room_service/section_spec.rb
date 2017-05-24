require 'rails_helper'

describe RoomService::Section do
  it { should belong_to(:category).inverse_of(:sections).with_foreign_key('room_service_category_id') }
  it { should have_many(:items).inverse_of(:section).with_foreign_key('room_service_section_id') }

  it { should validate_presence_of :title }
end
