class RoomService::Order < ApplicationRecord
  belongs_to :user, inverse_of: :room_service_orders
  belongs_to :reservation, inverse_of: :room_service_orders, autosave: true
  has_many :cart_items, dependent: :destroy, inverse_of: :order, foreign_key: 'room_service_order_id'

  validate :reservation_belongs_to_user
  validate :reservation_includes_current_day
  validate :reservation_has_room_number_when_setting_status_to_complete
  validates_presence_of :cart_items
  validates_presence_of :payment_type
  validates_presence_of :status

  enum status: [:open, :complete]
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
      reservation.nil? || reservation.includes_today?
  end

  def reservation_has_room_number_when_setting_status_to_complete
    errors.add(:reservation, :does_not_have_room_number, message: "doesn't have a room number") unless
      reservation.nil? || self.open? || reservation.room_number.present?
  end
end
