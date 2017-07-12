class RenameAllowsMultipleChoicesInRoomServiceItemChoices < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_item_choices, :allows_multiple_choices, :allows_multiple_options
  end
end
