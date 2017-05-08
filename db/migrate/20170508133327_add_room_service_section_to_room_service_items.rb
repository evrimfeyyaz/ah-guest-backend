class AddRoomServiceSectionToRoomServiceItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_items, :room_service_section, foreign_key: true
  end
end
