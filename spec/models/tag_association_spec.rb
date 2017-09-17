require 'rails_helper'

describe RoomService::Item::TagAssociation do
  it { should belong_to(:item) }
  it { should belong_to(:tag) }

  it {
    subject = create(:room_service_item_tag_association)
    should validate_uniqueness_of(:tag).scoped_to(:room_service_item_id)
  }
end
