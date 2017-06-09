require 'rails_helper'

describe RoomService::ChoicesForOption do
  it { should belong_to(:option).with_foreign_key('room_service_option_id') }
  it { should belong_to(:cart_item).with_foreign_key('room_service_cart_item_id').inverse_of(:choices_for_options) }
  it { should have_and_belong_to_many(:selected_choices).
    join_table('room_service_choices_for_options_room_service_choices').
    class_name('RoomService::Choice') }
end
