class RoomService::ItemOption < ApplicationRecord
  has_many :possible_choices, foreign_key: :room_service_item_option_id, class_name: 'RoomService::ItemOptionChoice'
end
