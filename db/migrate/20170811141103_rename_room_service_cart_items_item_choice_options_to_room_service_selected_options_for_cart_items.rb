class RenameRoomServiceCartItemsItemChoiceOptionsToRoomServiceSelectedOptionsForCartItems < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_cart_items_item_choice_options, :id, :primary_key, first: true
    rename_table :room_service_cart_items_item_choice_options, :room_service_selected_options_for_cart_items
  end
end
