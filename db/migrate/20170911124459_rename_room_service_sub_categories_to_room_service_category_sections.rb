class RenameRoomServiceSubCategoriesToRoomServiceCategorySections < ActiveRecord::Migration[5.1]
  def change
    rename_index :room_service_sub_categories, :index_room_service_sub_categories_on_room_service_category_id, :index_room_service_sections_on_category_id
    rename_table :room_service_sub_categories, :room_service_category_sections
    rename_column :room_service_items, :room_service_sub_category_id, :room_service_category_section_id
  end
end
