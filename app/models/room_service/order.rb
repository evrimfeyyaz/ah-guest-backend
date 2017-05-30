class RoomService::Order < ApplicationRecord
  belongs_to :user, inverse_of: :room_service_orders
  belongs_to :reservation, inverse_of: :room_service_orders
  has_many :cart_items, dependent: :destroy, inverse_of: :order, foreign_key: 'room_service_order_id'

  accepts_nested_attributes_for :cart_items
  validates_associated :cart_items
end