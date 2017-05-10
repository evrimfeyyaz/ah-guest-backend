class CreateJoinTableRoomServiceItemsRoomServiceItemAttributes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :items, :item_attributes, table_name: :room_service_items_room_service_item_attributes do |t|
      t.index [:item_id, :item_attribute_id], unique: true, name: 'by_item_id_and_item_attribute_id'
      t.index [:item_attribute_id, :item_id], unique: true, name: 'by_item_attribute_id_and_item_id'
    end
  end
end
