class RenameColumnsInRoomServiceItemsTags < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_items_tags, :item_id, :room_service_item_id
    rename_column :room_service_items_tags, :tag_id, :room_service_tag_id
  end
end
