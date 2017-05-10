class RoomService::ItemAttribute < ApplicationRecord
  has_and_belongs_to_many :items, class_name: 'RoomService::Item', join_table: 'room_service_items_room_service_item_attributes'
end
