class RoomService::Tag < ApplicationRecord
  has_and_belongs_to_many :items, inverse_of: :tags, foreign_key: 'room_service_tag_id',
                          association_foreign_key: 'room_service_item_id'

  validates_presence_of :title
end
