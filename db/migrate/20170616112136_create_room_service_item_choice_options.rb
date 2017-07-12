class CreateRoomServiceItemChoiceOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_item_choice_options do |t|
      t.string :title
      t.decimal :price
      t.references :room_service_item_choice, foreign_key: true, index: { name: 'index_r_s_item_choice_options_on_r_s_item_choice_id' }
    end
  end
end
