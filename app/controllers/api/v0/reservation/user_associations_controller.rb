class Api::V0::Reservation::UserAssociationsController < ApiController
  def create
    load_reservation
    build_reservation_user_association
    authorize @reservation_user_association
    save_reservation_user_association or render_validation_error_json(@reservation_user_association)
  end

  private

  def load_reservation
    load_reservation_by_confirmation_code
    load_reservation_by_check_in_date
  end

  def load_reservation_by_confirmation_code
    confirmation_code = permitted_attributes(Reservation::UserAssociation)[:reservation_attributes][:confirmation_code]

    @reservation ||= Reservation.find_by(confirmation_code: confirmation_code) if confirmation_code.present?
  end

  def load_reservation_by_check_in_date
    check_in_date = permitted_attributes(Reservation::UserAssociation)[:reservation_attributes][:check_in_date]
    room_number = permitted_attributes(Reservation::UserAssociation)[:reservation_attributes][:room_number]

    if check_in_date.present? && room_number.present?
      @reservation ||= Reservation.where(check_in_date: check_in_date, room_number: room_number).take
    end
  end

  def build_reservation_user_association
    @reservation_user_association ||= reservation_user_association_scope.build
    @reservation_user_association.reservation = @reservation
  end

  def save_reservation_user_association
    render_reservation_user_association_json if @reservation_user_association.save
  end

  def render_reservation_user_association_json
    render json: @reservation_user_association
  end

  def reservation_user_association_scope
    Reservation::UserAssociation.where(user_id: params[:user_id])
  end
end