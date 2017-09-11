require 'rails_helper'

describe RoomService::Item do
  it { should belong_to(:category_section).
    counter_cache('room_service_items_count').
    inverse_of(:items).
    with_foreign_key('room_service_category_section_id') }
  it { should have_many(:tag_associations).inverse_of(:item) }
  it { should have_many(:tags).through(:tag_associations) }
  it { should have_many(:choice_associations).inverse_of(:item) }
  it { should have_many(:choices).through(:choice_associations) }
  it { should have_many(:cart_items).inverse_of(:item).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_length_of(:short_description).is_at_most(100) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end