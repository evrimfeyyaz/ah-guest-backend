class RoomService::CartItem < ApplicationRecord
  belongs_to  :order, inverse_of: :cart_items, foreign_key: 'room_service_order_id'
  belongs_to  :item, foreign_key: 'room_service_item_id'
  has_many    :choices_for_options, foreign_key: 'room_service_cart_item_id'

  validates_numericality_of :quantity, greater_than: 0

  accepts_nested_attributes_for :choices_for_options
end