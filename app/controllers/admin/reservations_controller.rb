class Admin::ReservationsController < AdminController
  def index
    @reservations = Reservation.order(check_in_date: :desc).page params[:page]
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      flash[:success] = 'Reservation created'

      redirect_to admin_reservations_url
    else
      render :new
    end
  end

  def update
    @reservation = Reservation.find(params[:id])

    if @reservation.update_attributes(reservation_params)
      flash[:success] = 'Reservation updated'

      redirect_to admin_reservations_url
    else
      render :edit
    end
  end

  private

  def load_reservations
    @reservations ||= reservation_scope.to_a
  end

  def reservation_scope
    Reservation.all
  end
end