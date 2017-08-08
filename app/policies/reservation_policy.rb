class ReservationPolicy < ApplicationPolicy
  def permitted_parameters
    [:check_in_date, :check_out_date, :room_number, :confirmation_code]
  end
end