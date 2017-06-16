class DropRoomServiceChoicesOptionsAndRelevantTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :room_service_choices_for_options_room_service_choices
    drop_table :room_service_items_room_service_options
    drop_table :room_service_choices_for_options
    remove_reference :room_service_choices, :room_service_option
    drop_table :room_service_options
    drop_table :room_service_choices
  end
end
