class AddImageToRoomServiceCategories < ActiveRecord::Migration[5.1]
  def up
    add_attachment :room_service_categories, :image
  end

  def down
    remove_attachment :room_service_categories, :image
  end
end
