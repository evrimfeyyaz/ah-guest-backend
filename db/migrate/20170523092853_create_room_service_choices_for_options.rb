class CreateRoomServiceChoicesForOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_choices_for_options do |t|
      t.references :room_service_option, foreign_key: true, index: { name: 'room_service_choices_for_options_on_option_id' }
      t.integer :number_of_possible_choices

      t.timestamps
    end
  end
end
