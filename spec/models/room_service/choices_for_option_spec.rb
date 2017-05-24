require 'rails_helper'

describe RoomService::ChoicesForOption do
  it { should belong_to(:option).with_foreign_key('room_service_option_id') }
  it { should have_and_belong_to_many(:selected_choices).
    join_table('room_service_choices_for_options_room_service_choices').
    class_name('RoomService::Choice') }
end
