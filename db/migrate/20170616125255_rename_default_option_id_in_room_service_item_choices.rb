class RenameDefaultOptionIdInRoomServiceItemChoices < ActiveRecord::Migration[5.1]
  def change
    remove_reference :room_service_item_choices, :default_option
    add_reference :room_service_item_choices, :default_room_service_item_choice_option, index: { name: 'by_r_s_item_choice_option_id' }
  end
end
