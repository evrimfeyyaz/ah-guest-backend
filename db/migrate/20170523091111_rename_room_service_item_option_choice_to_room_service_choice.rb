class RenameRoomServiceItemOptionChoiceToRoomServiceChoice < ActiveRecord::Migration[5.1]
  def change
    rename_table :room_service_item_option_choices, :room_service_choices
  end
end
