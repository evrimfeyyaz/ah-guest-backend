require 'rails_helper'

describe RoomService::Tag do
  it { should have_many(:item_tag_associations).inverse_of(:tag).dependent(:destroy) }
  it { should have_many(:items).through(:item_tag_associations) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(30) }
end
