class AddRoomServiceItemChoiceOptionReferenceToRoomServiceItemChoices < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_item_choices, :default_option, foreign_key: { to_table: :room_service_item_choice_options }
  end
end
