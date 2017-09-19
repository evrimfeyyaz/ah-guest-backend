class Reservation < ApplicationRecord
  has_many :user_reservation_associations, class_name: 'User::ReservationAssociation', dependent: :destroy
  has_many :users, through: :user_reservation_associations, inverse_of: :reservations
  has_many :room_service_orders, class_name: 'RoomService::Order', inverse_of: :reservation, dependent: :destroy

  validates_presence_of :confirmation_code, :check_in_date, :check_out_date
  validates_uniqueness_of :confirmation_code, case_sensitive: false
  validates_length_of :confirmation_code, maximum: 30
  validates_length_of :room_number, maximum: 5
  validate :check_out_date_is_not_before_check_in_date

  def includes_today?
    check_in_date <= Date.today && check_out_date >= Date.today
  end

  private

  def check_out_date_is_not_before_check_in_date
    errors.add(:check_out_date, :before_check_in_date, message: "can't be before check-in date") unless
      check_out_date.nil? || check_in_date.nil? || check_in_date <= check_out_date
  end
end