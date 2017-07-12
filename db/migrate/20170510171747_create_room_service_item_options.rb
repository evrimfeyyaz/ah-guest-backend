class CreateRoomServiceItemOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_item_options do |t|
      t.string :title
      t.boolean :optional, default: true
      t.boolean :allows_multiple_choices, default: false

      t.timestamps
    end
  end
end
