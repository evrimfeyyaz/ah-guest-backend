class CreateRoomServiceSections < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_sections do |t|
      t.string :title

      t.timestamps
    end
  end
end
