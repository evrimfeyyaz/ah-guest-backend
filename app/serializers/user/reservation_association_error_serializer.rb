class User::ReservationAssociationErrorSerializer < ErrorSerializer
  def error_type
    :user_reservation_association
  end
end