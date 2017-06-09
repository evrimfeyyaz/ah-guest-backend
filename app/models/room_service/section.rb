class RoomService::Section < ApplicationRecord
  belongs_to  :category, foreign_key: 'room_service_category_id', inverse_of: :sections
  has_many    :items, foreign_key: 'room_service_section_id', inverse_of: :section

  validates_presence_of :title

  delegate :available?, to: 'category', allow_nil: true
  delegate :available_from, to: 'category', allow_nil: true
  delegate :available_until, to: 'category', allow_nil: true
end