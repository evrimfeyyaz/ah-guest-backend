class CreateJoinTableRoomServiceItemsRoomServiceItemOptions < ActiveRecord::Migration[5.1]
  def change
    create_join_table :items, :item_options, table_name: :room_service_items_room_service_item_options do |t|
      t.index [:item_id, :item_option_id], unique: true, name: 'by_item_id_and_item_option_id'
      t.index [:item_option_id, :item_id], unique: true, name: 'by_item_option_id_and_item_id'
    end
  end
end