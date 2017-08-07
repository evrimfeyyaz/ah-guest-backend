require 'rails_helper'

describe RoomService::SubCategory do
  it { should belong_to(:category).inverse_of(:sub_categories).with_foreign_key('room_service_category_id') }
  it { should have_many(:items).inverse_of(:sub_category).with_foreign_key('room_service_sub_category_id').dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }
end
