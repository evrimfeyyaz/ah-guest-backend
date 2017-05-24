class RoomService::Tag < ApplicationRecord
  has_and_belongs_to_many :items, join_table: 'room_service_items_room_service_tags',
                          inverse_of: :tags

  validates_presence_of :title
end
