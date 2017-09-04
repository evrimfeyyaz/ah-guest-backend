class RoomService::Item::TagAssociation < ApplicationRecord
  belongs_to :item, class_name: 'RoomService::Item', foreign_key: 'room_service_item_id'
  belongs_to :tag, class_name: 'RoomService::Tag', foreign_key: 'room_service_tag_id'
end