class Api::V0::Users::ReservationAssociationsController < ApiController
  def create
    load_reservation
    build_user_reservation_association
    authorize @user_reservation_association
    save_user_reservation_association or render_validation_error_json(@user_reservation_association)
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

  def build_user_reservation_association
    @user_reservation_association ||= user_reservation_association_scope.build
    @user_reservation_association.reservation = @reservation
  end

  def save_user_reservation_association
    render_user_reservation_association_json if @user_reservation_association.save
  end

  def render_user_reservation_association_json
    render json: @user_reservation_association
  end

  def user_reservation_association_scope
    User::ReservationAssociation.where(user_id: params[:user_id])
  end
end