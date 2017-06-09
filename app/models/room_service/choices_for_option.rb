class RoomService::ChoicesForOption < ApplicationRecord
  belongs_to :option, foreign_key: 'room_service_option_id'
  belongs_to :cart_item, foreign_key: 'room_service_cart_item_id', inverse_of: :choices_for_options
  has_and_belongs_to_many :selected_choices, join_table: 'room_service_choices_for_options_room_service_choices',
                          class_name: 'RoomService::Choice'
end