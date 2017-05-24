class ChangeItemOptionIdToOptionId < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_items_room_service_options, :item_option_id, :option_id
  end
end
