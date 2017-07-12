class RenameRoomServiceItemsRoomServiceItemAttributesToRoomServiceItemsRoomServiceTags < ActiveRecord::Migration[5.1]
  def change
    rename_table :room_service_items_room_service_item_attributes, :room_service_items_room_service_tags
  end
end
