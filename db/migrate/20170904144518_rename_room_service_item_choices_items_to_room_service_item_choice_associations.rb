class RenameRoomServiceItemChoicesItemsToRoomServiceItemChoiceAssociations < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_item_choices_items, :id, :primary_key, first: true
    rename_table :room_service_item_choices_items, :room_service_item_choice_associations
  end
end
