class RoomService::ItemOptionChoice < ApplicationRecord
  belongs_to :option, foreign_key: :room_service_item_option_id, class_name: 'RoomService::ItemOption'
end
