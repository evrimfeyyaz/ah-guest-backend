class RenameRoomServiceItemOptionsToRoomServiceOptions < ActiveRecord::Migration[5.1]
  def change
    rename_table :room_service_item_options, :room_service_options
  end
end
