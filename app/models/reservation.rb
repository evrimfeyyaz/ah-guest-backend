class Reservation < ApplicationRecord
  belongs_to :user, inverse_of: :reservations, optional: true
  has_many :room_service_orders, class_name: 'RoomService::Order', inverse_of: :reservation, dependent: :destroy

  validates_presence_of :confirmation_code, :check_in_date, :check_out_date
  validates_uniqueness_of :confirmation_code, case_sensitive: false
  validate :check_out_date_cannot_be_before_check_in_date

  def includes_current_day?
    check_in_date <= Date.current && check_out_date >= Date.current
  end

  private

  def check_out_date_cannot_be_before_check_in_date
    errors.add(:check_out_date, :before_check_in_date, message: "can't be before check-in date") unless
      check_out_date.nil? || check_in_date.nil? || check_in_date <= check_out_date
  end
end