class RoomService::CartItem < ApplicationRecord
  belongs_to :order, inverse_of: :cart_items, foreign_key: 'room_service_order_id'
  belongs_to :item, foreign_key: 'room_service_item_id'
  has_many :choices_for_options, foreign_key: 'room_service_cart_item_id', inverse_of: :cart_item

  validates_numericality_of :quantity, greater_than: 0
  validate :availability_at_the_moment

  accepts_nested_attributes_for :choices_for_options

  private

  def availability_at_the_moment
    errors.add(:base, :not_available_at_the_moment,
               message: '"%{item_title}" is not available at the moment (only available from %{item_available_from} to %{item_available_until})',
               item_title: item.title,
               item_available_from: item.available_from.strftime('%H:%M'),
               item_available_until: item.available_until.strftime('%H:%M'),
               item_id: item.id) unless item.nil? || item.available?(DateTime.current)
  end
end