class CreateRoomServiceItemChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_item_choices do |t|
      t.string :title
      t.boolean :optional
      t.boolean :allows_multiple_choices
    end
  end
end
