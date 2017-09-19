class Reservation::UserAssociationErrorSerializer < ErrorSerializer
  def error_type
    :reservation_user_association
  end
end