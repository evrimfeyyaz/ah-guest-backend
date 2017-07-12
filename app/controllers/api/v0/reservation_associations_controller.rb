class Api::V0::ReservationAssociationsController < ApiController
  rescue_from ActionController::ParameterMissing, with: :respond_with_bad_request

  def create
    confirmation_code = reservation_association_params.has_key?(:confirmation_code) ?
      reservation_association_params[:confirmation_code] : nil

    check_in_date = reservation_association_params.has_key?(:check_in_date) ?
      Date.parse(reservation_association_params[:check_in_date]) : nil

    reservation_associator = ReservationAssociator.new(user: current_user,
                                                       confirmation_code: confirmation_code,
                                                       check_in_date: check_in_date)

    if reservation_associator.associate
      render json: reservation_associator.associated_reservation
    else
      render json: reservation_associator, status: :unprocessable_entity, serializer: ReservationAssociationErrorSerializer
    end
  end

  private

  def reservation_association_params
    params.require(:reservation).permit(:check_in_date, :confirmation_code)
  end

  def respond_with_bad_request
    head :bad_request
  end
end