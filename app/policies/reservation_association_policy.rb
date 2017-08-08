class ReservationAssociationPolicy < ApplicationPolicy
  def create?
    record.user == user
  end

  def permitted_attributes
    [reservation_attributes: [:check_in_date, :room_number, :confirmation_code]]
  end
end