class Api::V0::ReservationAssociationsController < ApiController
  def create
    confirmation_code = reservation_association_params.has_key?(:confirmation_code) ?
      reservation_association_params[:confirmation_code] : nil

    check_in_date = reservation_association_params.has_key?(:check_in_date) ?
      Date.parse(reservation_association_params[:check_in_date]) : nil

    if confirmation_code
      reservation = Reservation.where(confirmation_code: confirmation_code)

      if reservation.count == 0
        return head :bad_request
      end

      reservation = reservation.take

      reservation.user = current_user

      if reservation.save
        return head :no_content
      end
    elsif check_in_date
      reservations_with_check_in_date = Reservation.where(check_in_date: check_in_date,
                                                          user_id: nil,
                                                          first_name: current_user.first_name,
                                                          last_name: current_user.last_name)

      reservations_count = reservations_with_check_in_date.count
      if reservations_count > 1 || reservations_count == 0
        return head :bad_request
      end

      reservation = reservations_with_check_in_date.first

      reservation.user = current_user

      if reservation.save
        return head :no_content
      end
    else
      return head :bad_request
    end
  end

  private

  def reservation_association_params
    params.require(:reservation).permit(:check_in_date, :confirmation_code)
  end
end