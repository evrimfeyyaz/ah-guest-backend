class Stay < ApplicationRecord
  belongs_to :user, inverse_of: :stays, optional: true
  has_many :room_service_orders, class_name: 'RoomService::Order', inverse_of: :stay

  validates_presence_of :confirmation_code, :check_in_date, :check_out_date
  validate :check_out_date_cannot_be_before_check_in_date

  private

  def check_out_date_cannot_be_before_check_in_date
    errors.add(:check_out_date, :before_check_in_date, message: "can't be before check-in date") unless
      check_out_date.nil? || check_in_date.nil? || check_in_date <= check_out_date
  end
end