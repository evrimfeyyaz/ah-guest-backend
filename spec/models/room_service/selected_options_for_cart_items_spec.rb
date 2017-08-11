require 'rails_helper'

describe RoomService::SelectedOptionsForCartItems do
  it { should belong_to :cart_item }
  it { should belong_to :selected_option }
end
