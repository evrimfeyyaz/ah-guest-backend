class RenameRoomServiceSectionsToRoomServiceSubCategories < ActiveRecord::Migration[5.1]
  def change
    rename_table :room_service_sections, :room_service_sub_categories
  end
end
