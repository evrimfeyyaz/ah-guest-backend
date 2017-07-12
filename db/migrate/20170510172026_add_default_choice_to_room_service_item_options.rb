class AddDefaultChoiceToRoomServiceItemOptions < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_item_options, :default_choice, foreign_key: { to_table: :room_service_item_option_choices }
  end
end
