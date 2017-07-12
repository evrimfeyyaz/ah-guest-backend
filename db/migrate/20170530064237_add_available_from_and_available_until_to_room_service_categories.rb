class AddAvailableFromAndAvailableUntilToRoomServiceCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_categories, :available_from, :time
    add_column :room_service_categories, :available_until, :time
  end
end
