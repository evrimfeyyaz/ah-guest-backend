class CreateJoinTableRoomServiceItemsItemChoices < ActiveRecord::Migration[5.1]
  def change
    create_join_table :room_service_items, :room_service_item_choices do |t|
      t.index [:room_service_item_id, :room_service_item_choice_id], name: 'by_r_s_item_id_and_r_s_item_choice_id'
      t.index [:room_service_item_choice_id, :room_service_item_id], name: 'by_r_s_item_choice_id_and_r_s_item_id'
    end
  end
end
