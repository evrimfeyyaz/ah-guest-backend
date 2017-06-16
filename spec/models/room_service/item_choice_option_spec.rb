require 'rails_helper'

describe RoomService::ItemChoiceOption do
  it { should belong_to(:choice).inverse_of(:possible_options).
    with_foreign_key('room_service_item_choice_id').
    class_name('RoomService::ItemChoice') }

  it { should validate_presence_of :title }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end
