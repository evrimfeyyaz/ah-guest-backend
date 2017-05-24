class RoomService::ChoicesForOption < ApplicationRecord
  belongs_to              :option, foreign_key: 'room_service_option_id'
  has_and_belongs_to_many :selected_choices, join_table: 'room_service_choices_for_options_room_service_choices',
    class_name: 'RoomService::Choice'
end