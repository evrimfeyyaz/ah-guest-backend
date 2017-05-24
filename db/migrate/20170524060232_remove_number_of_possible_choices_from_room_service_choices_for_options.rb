class RemoveNumberOfPossibleChoicesFromRoomServiceChoicesForOptions < ActiveRecord::Migration[5.1]
  def change
    remove_column :room_service_choices_for_options, :number_of_possible_choices, :string
  end
end