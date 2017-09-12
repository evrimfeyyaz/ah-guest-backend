class RoomService::Order < ApplicationRecord
  belongs_to :user, inverse_of: :room_service_orders
  belongs_to :reservation, inverse_of: :room_service_orders
  has_many :cart_items, dependent: :destroy, inverse_of: :order, foreign_key: 'room_service_order_id'

  validate :reservation_belongs_to_user
  validate :reservation_includes_current_day
  validates_presence_of :cart_items
  validates_presence_of :payment_type
  validates_presence_of :status

  enum status: [:open, :completed]
  enum payment_type: [:room_account, :cash, :credit_card]

  accepts_nested_attributes_for :cart_items

  def total
    cart_items.map(&:total).reduce(:+)
  end

  private

  def reservation_belongs_to_user
    errors.add(:reservation, :does_not_belong_to_user, message: "doesn't belong to the user") unless
      reservation.nil? || user.nil? || user.reservations.include?(reservation)
  end

  def reservation_includes_current_day
    errors.add(:reservation, :does_not_include_current_day, message: "doesn't include the current day") unless
      reservation.nil? || reservation.includes_current_day?
  end
end