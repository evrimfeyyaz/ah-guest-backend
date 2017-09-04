require 'rails_helper'

describe RoomService::CartItem::SelectedOptionAssociation do
  it { should belong_to :cart_item }
  it { should belong_to :selected_option }
end
