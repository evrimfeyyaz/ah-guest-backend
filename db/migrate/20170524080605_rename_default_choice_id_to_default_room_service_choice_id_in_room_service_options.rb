class RenameDefaultChoiceIdToDefaultRoomServiceChoiceIdInRoomServiceOptions < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_options, :default_choice_id, :default_room_service_choice_id
  end
end
