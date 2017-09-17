require 'rails_helper'

describe RoomService::Item::ChoiceAssociation do
  it { should belong_to :item }
  it { should belong_to :choice }

  it {
    subject = create(:room_service_item_choice_association)
    should validate_uniqueness_of(:choice).scoped_to(:room_service_item_id)
  }
end
