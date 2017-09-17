class RoomService::Category::Section < ApplicationRecord
  belongs_to  :category, foreign_key: 'room_service_category_id', inverse_of: :sections
  has_many    :items, foreign_key: 'room_service_category_section_id',
              inverse_of: :category_section, dependent: :destroy

  validates_presence_of :title
  validates_length_of :title, maximum: 50

  delegate :available_at?, to: 'category', allow_nil: true
  delegate :available_from, to: 'category', allow_nil: true
  delegate :available_until, to: 'category', allow_nil: true
  delegate :available_from_local, to: 'category', allow_nil: true
  delegate :available_until_local, to: 'category', allow_nil: true
end