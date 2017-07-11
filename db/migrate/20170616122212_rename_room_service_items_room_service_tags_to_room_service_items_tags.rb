class RenameRoomServiceItemsRoomServiceTagsToRoomServiceItemsTags < ActiveRecord::Migration[5.1]
  def change
    rename_table :room_service_items_room_service_tags, :room_service_items_tags
  end
end
