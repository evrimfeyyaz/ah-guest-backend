class RenameColumnsInRoomServiceSelectedOptionsForCartItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_selected_options_for_cart_items, :room_service_cart_item_id, :cart_item_id
    rename_column :room_service_selected_options_for_cart_items, :room_service_item_choice_option_id, :item_choice_option_id
  end
end
