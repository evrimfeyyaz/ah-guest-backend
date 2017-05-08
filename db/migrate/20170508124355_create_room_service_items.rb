class CreateRoomServiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_items do |t|
      t.string :title
      t.string :short_description
      t.decimal :price, :precision => 19, :scale => 4, :default => 0

      t.timestamps
    end
  end
end
