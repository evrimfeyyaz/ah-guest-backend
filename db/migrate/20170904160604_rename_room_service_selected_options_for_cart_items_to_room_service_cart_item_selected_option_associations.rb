class RenameRoomServiceSelectedOptionsForCartItemsToRoomServiceCartItemSelectedOptionAssociations < ActiveRecord::Migration[5.1]
  def change
    rename_table :room_service_selected_options_for_cart_items, :room_service_cart_item_selected_option_associations
    add_timestamps :room_service_cart_item_selected_option_associations
    rename_column :room_service_cart_item_selected_option_associations, :cart_item_id, :room_service_cart_item_id
    rename_column :room_service_cart_item_selected_option_associations, :item_choice_option_id, :room_service_item_choice_option_id
  end
end
