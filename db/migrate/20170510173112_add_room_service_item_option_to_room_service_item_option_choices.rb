class AddRoomServiceItemOptionToRoomServiceItemOptionChoices < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_item_option_choices, :room_service_item_option, foreign_key: true, index: { name: 'by_room_service_item_option_id' }
  end
end
