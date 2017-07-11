class AddReferenceRoomServiceSubCategoryToRoomServiceItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_items, :room_service_sub_category, foreign_key: true
  end
end
