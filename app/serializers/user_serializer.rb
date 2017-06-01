class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :auth_token, :current_or_upcoming_reservation

  # For some reason, I was not able to get the :current_or_upcoming_reservation
  # method to be serialized by a custom serializer class.
  def current_or_upcoming_reservation
    reservation = object.current_or_upcoming_reservation

    if reservation == nil
      return nil
    end

    {
      'id' => reservation.id,
      'check_in_date' => reservation.check_in_date,
      'check_out_date' => reservation.check_out_date,
      'first_name' => reservation.first_name,
      'last_name' => reservation.last_name,
      'room_number' => reservation.room_number,
      'confirmation_code' => reservation.confirmation_code
    }
  end
end