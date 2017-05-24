class RoomService::Item < ApplicationRecord
  belongs_to :section, foreign_key: 'room_service_section_id', counter_cache: 'room_service_items_count', inverse_of: :items
  has_and_belongs_to_many :tags, join_table: 'room_service_items_room_service_tags', inverse_of: :items
  has_and_belongs_to_many :options, join_table: 'room_service_items_room_service_options', inverse_of: :items

  validates_presence_of :title
  validates_numericality_of :price, greater_than_or_equal_to: 0
end