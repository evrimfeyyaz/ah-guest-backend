class RoomService::Item < ApplicationRecord
  belongs_to :section, foreign_key: :room_service_section_id, counter_cache: :room_service_items_count
  has_and_belongs_to_many :item_attributes, class_name: 'RoomService::ItemAttribute', join_table: 'room_service_items_room_service_item_attributes'

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
