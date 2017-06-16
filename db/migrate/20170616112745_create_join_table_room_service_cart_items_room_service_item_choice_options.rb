class CreateJoinTableRoomServiceCartItemsRoomServiceItemChoiceOptions < ActiveRecord::Migration[5.1]
  def change
    create_join_table :room_service_cart_items, :room_service_item_choice_options do |t|
      t.index [:room_service_cart_item_id, :room_service_item_choice_option_id], name: 'by_r_s_cart_item_id_and_r_s_item_choice_option_id'
      t.index [:room_service_item_choice_option_id, :room_service_cart_item_id], name: 'by_r_s_item_choice_option_id_and_r_s_cart_item_id'
    end
  end
end
