class ChangeRoomServiceItemOptionIdToRoomServiceOptionId < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_choices, :room_service_item_option_id, :room_service_option_id
  end
end
