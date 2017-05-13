class CreateRoomServiceItemOptionChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_item_option_choices do |t|
      t.string :title
      t.decimal :price

      t.timestamps
    end
  end
end
