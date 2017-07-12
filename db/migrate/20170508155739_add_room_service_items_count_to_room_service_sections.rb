class AddRoomServiceItemsCountToRoomServiceSections < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_sections, :room_service_items_count, :integer, default: 0
  end
end
