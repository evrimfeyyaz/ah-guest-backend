class RoomService::Order < ApplicationRecord
  belongs_to :user

  has_many :cart_items, foreign_key: 'room_service_order_id'

  accepts_nested_attributes_for :cart_items
end
