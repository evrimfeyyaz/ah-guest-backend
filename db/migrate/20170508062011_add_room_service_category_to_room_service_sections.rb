class AddRoomServiceCategoryToRoomServiceSections < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_sections, :room_service_category, foreign_key: true
  end
end
