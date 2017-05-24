class RenameIndexesAfterRefactor < ActiveRecord::Migration[5.1]
  def change
    rename_index :room_service_choices, 'by_room_service_item_option_id', 'by_room_service_option_id'
    rename_index :room_service_items_room_service_options, 'by_item_id_and_item_option_id', 'by_item_id_and_option_id'
    rename_index :room_service_items_room_service_options, 'by_item_option_id_and_item_id', 'by_option_id_and_item_id'
  end
end
