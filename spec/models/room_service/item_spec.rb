require 'rails_helper'

describe RoomService::Item do
  it { should belong_to(:category_section).counter_cache('room_service_items_count').inverse_of(:items) }
  it { should have_many(:item_tag_associations).inverse_of(:item).dependent(:destroy) }
  it { should have_many(:tags).through(:item_tag_associations) }
  it { should have_many(:item_choice_associations).inverse_of(:item).dependent(:destroy) }
  it { should have_many(:choices).through(:item_choice_associations) }
  it { should have_many(:cart_items).inverse_of(:item).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_length_of(:short_description).is_at_most(100) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it { should delegate_method(:available_at?).to(:category_section) }
  it { should delegate_method(:available_from).to(:category_section) }
  it { should delegate_method(:available_until).to(:category_section) }
  it { should delegate_method(:available_from_local).to(:category_section) }
  it { should delegate_method(:available_until_local).to(:category_section) }
end