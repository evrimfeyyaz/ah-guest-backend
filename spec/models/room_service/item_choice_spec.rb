require 'rails_helper'

describe RoomService::ItemChoice do
  it { should have_many(:possible_options).dependent(:destroy).inverse_of(:choice).class_name('ItemChoiceOption') }
  it { should have_and_belong_to_many(:items).inverse_of(:choices) }
  it { should belong_to(:default_option).class_name('RoomService::ItemChoiceOption').
    with_foreign_key('default_room_service_item_choice_option_id') }

  it { should validate_presence_of :title }
end