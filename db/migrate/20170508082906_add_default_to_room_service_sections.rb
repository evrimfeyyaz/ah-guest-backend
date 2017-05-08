class AddDefaultToRoomServiceSections < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_sections, :default, :boolean
  end
end
