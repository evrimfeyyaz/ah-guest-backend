class RenameLongDescriptionInRoomServiceItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_items, :long_description, :description
  end
end
