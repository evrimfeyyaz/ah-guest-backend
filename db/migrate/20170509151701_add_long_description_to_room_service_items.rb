class AddLongDescriptionToRoomServiceItems < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_items, :long_description, :text
  end
end
