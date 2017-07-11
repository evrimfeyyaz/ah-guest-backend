class CreateJoinTableRoomServiceChoicesForOptionsRoomServiceChoices < ActiveRecord::Migration[5.1]
  def change
    create_join_table :choices_for_options, :choices, table_name: 'room_service_choices_for_options_room_service_choices' do |t|
      t.index [:choices_for_option_id, :choice_id], unique: true, name: 'by_choices_for_option_id_and_choice_id'
      t.index [:choice_id, :choices_for_option_id], unique: true, name: 'by_choice_id_and_choices_for_option_id'
    end
  end
end
