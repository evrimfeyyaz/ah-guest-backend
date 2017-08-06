class AddDefaultValueToOptionalAndAllowsMultipleOptionsInRoomServiceItemChoices < ActiveRecord::Migration[5.1]
  def change
    change_column :room_service_item_choices, :optional, :boolean, default: true
    change_column :room_service_item_choices, :allows_multiple_options, :boolean, default: false
  end
end
