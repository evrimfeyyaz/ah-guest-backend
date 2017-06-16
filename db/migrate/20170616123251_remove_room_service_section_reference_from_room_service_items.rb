class RemoveRoomServiceSectionReferenceFromRoomServiceItems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :room_service_items, :room_service_section
  end
end
