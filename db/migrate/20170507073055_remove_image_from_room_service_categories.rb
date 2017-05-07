class RemoveImageFromRoomServiceCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :room_service_categories, :image, :string
  end
end
