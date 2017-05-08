class RoomService::Section < ApplicationRecord
  belongs_to :category, foreign_key: :room_service_category_id
  has_many :items, foreign_key: :room_service_section_id

  validates :title, presence: true
end
