class CreateRoomServiceItemAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_item_attributes do |t|
      t.string :title

      t.timestamps
    end
  end
end
