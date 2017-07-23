class ReservationAssociationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def permitted_attributes
    [reservation_attributes: [:check_in_date, :room_number, :confirmation_code]]
  end
end