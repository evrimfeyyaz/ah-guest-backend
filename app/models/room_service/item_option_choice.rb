class RoomService::ItemOptionChoice < ApplicationRecord
  belongs_to :option, foreign_key: :room_service_item_option_id, class_name: 'RoomService::ItemOption'

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
