class RoomService::Item::TagAssociation < ApplicationRecord
  belongs_to :item, foreign_key: 'room_service_item_id'
  belongs_to :tag, foreign_key: 'room_service_tag_id'

  validates_uniqueness_of :tag, scope: :room_service_item_id
end