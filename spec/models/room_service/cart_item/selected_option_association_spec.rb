require 'rails_helper'

describe RoomService::CartItem::SelectedOptionAssociation do
  it { should belong_to :cart_item }
  it { should belong_to :selected_option }

  it {
    subject = create(:room_service_cart_item_selected_option_association)
    should validate_uniqueness_of(:selected_option).scoped_to(:room_service_cart_item_id)
  }
end
