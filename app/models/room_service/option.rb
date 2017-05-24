class RoomService::Option < ApplicationRecord
  has_many :possible_choices, foreign_key: :room_service_option_id, class_name: 'Choice',
           dependent: :destroy, inverse_of: :option
  has_and_belongs_to_many :items, join_table: 'room_service_items_room_service_options', inverse_of: :options

  validates_presence_of :title
end
