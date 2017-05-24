require 'rails_helper'

describe RoomService::Option do
  it { should have_many(:possible_choices).dependent(:destroy).inverse_of(:option).class_name('Choice') }
  it { should have_and_belong_to_many(:items).
    inverse_of(:options).
    join_table('room_service_items_room_service_options') }
  it { should belong_to(:default_choice).
    class_name('RoomService::Choice').
    with_foreign_key('default_room_service_choice_id') }

  it { should validate_presence_of :title }
end