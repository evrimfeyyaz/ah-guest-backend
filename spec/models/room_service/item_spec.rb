require 'rails_helper'

describe RoomService::Item do
  it { should belong_to(:sub_category).
    counter_cache('room_service_items_count').
    inverse_of(:items).
    with_foreign_key('room_service_sub_category_id') }
  it { should have_and_belong_to_many(:tags).inverse_of(:items) }
  it { should have_and_belong_to_many(:choices).inverse_of(:items) }

  it { should validate_presence_of :title }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end