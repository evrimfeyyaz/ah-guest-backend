class RoomService::CartItem < ApplicationRecord
  belongs_to :order, foreign_key: 'room_service_order_id'

  has_one :item
  # has_many :choices_for_options, foreign_key: 'room_service_order_id'
end