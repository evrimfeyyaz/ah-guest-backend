class ChangeTypeOfDescriptionInRoomServiceCategories < ActiveRecord::Migration[5.1]
  def up
    change_column :room_service_categories, :description, :string
  end

  def down
    change_column :room_service_categories, :description, :text
  end
end
