class RenameDefaultRoomServiceItemChoiceOptionIdInRoomServiceItemChoices < ActiveRecord::Migration[5.1]
  def change
    remove_reference :room_service_item_choices, :default_room_service_item_choice_option
    add_reference :room_service_item_choices, :default_option
  end
end
