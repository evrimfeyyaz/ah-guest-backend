class RenameItemAttributeIdToTagIdInRoomServiceItemsRoomServiceTags < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_items_room_service_tags, :item_attribute_id, :tag_id
    rename_index :room_service_items_room_service_tags, 'by_item_attribute_id_and_item_id', 'by_tag_id_and_item_id'
    rename_index :room_service_items_room_service_tags, 'by_item_id_and_item_attribute_id', 'by_item_id_and_tag_id'
  end
end
