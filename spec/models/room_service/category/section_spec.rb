require 'rails_helper'

describe RoomService::Category::Section do
  it { should belong_to(:category).inverse_of(:sections).with_foreign_key('room_service_category_id') }
  it { should have_many(:items).inverse_of(:category_section).with_foreign_key('room_service_category_section_id').dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }
end
