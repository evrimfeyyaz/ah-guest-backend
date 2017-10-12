class Api::V0::Users::ReservationAssociationsController < Api::V0::ApiController
  def create
    load_reservation
    build_reservation_association
    authorize @reservation_association
    save_reservation_association or render_validation_error_json(@reservation_association)
  end

  private

  def load_reservation
    load_reservation_by_confirmation_code
    load_reservation_by_check_in_date
  end

  def load_reservation_by_confirmation_code
    confirmation_code = permitted_attributes(User::ReservationAssociation)[:reservation_attributes][:confirmation_code]

    @reservation ||= Reservation.find_by(confirmation_code: confirmation_code) if confirmation_code.present?
  end

  def load_reservation_by_check_in_date
    check_in_date = permitted_attributes(User::ReservationAssociation)[:reservation_attributes][:check_in_date]
    room_number = permitted_attributes(User::ReservationAssociation)[:reservation_attributes][:room_number]

    if check_in_date.present? && room_number.present?
      @reservation ||= Reservation.where(check_in_date: check_in_date, room_number: room_number).take
    end
  end

  def build_reservation_association
    @reservation_association ||= reservation_association_scope.build
    @reservation_association.reservation = @reservation
  end

  def save_reservation_association
    render_reservation_association_json if @reservation_association.save
  end

  def render_reservation_association_json
    render json: @reservation_association
  end

  def reservation_association_scope
    User::ReservationAssociation.where(user_id: params[:user_id])
  end
end