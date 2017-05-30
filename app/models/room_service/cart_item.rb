class RoomService::CartItem < ApplicationRecord
  belongs_to :order, inverse_of: :cart_items, foreign_key: 'room_service_order_id'
  belongs_to :item, foreign_key: 'room_service_item_id'
  has_many :choices_for_options, foreign_key: 'room_service_cart_item_id'

  validates_numericality_of :quantity, greater_than: 0
  validate :availability_at_the_moment

  accepts_nested_attributes_for :choices_for_options

  delegate :title, to: :item, allow_nil: true

  private

  def availability_at_the_moment
    # TODO: Add available times to error details.
    errors.add(:base, :not_available_at_the_moment,
               message: '"%{title}" is not available at the moment',
               title: title) unless item.nil? || item.available?(DateTime.current)
  end
end