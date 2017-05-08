class RoomService::Item < ApplicationRecord
  belongs_to :section, foreign_key: :room_service_section_id, counter_cache: :room_service_items_count

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
