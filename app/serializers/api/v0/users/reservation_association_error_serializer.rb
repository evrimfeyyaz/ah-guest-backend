class Api::V0::User::ReservationAssociationErrorSerializer < Api::V0::ErrorSerializer
  def error_type
    :user_reservation_association
  end
end