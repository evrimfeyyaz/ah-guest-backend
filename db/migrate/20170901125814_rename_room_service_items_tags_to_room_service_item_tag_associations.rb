class RenameRoomServiceItemsTagsToRoomServiceItemTagAssociations < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_items_tags, :id, :primary_key, first: true
    add_timestamps :room_service_items_tags
    rename_table :room_service_items_tags, :room_service_item_tag_associations
  end
end