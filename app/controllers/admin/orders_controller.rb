class Admin::OrdersController < Admin::BaseController
  def index
    @orders = RoomService::Order.order(created_at: :desc)
  end

  def show
    @order = RoomService::Order.find(params[:id])
  end

  def complete
    @order = RoomService::Order.find(params[:id])

    if reservation_params[:room_number].present?
      @order.reservation.room_number = reservation_params[:room_number]
      @order.reservation.save
    end

    if @order.reservation.room_number.blank?
      render 'admin/room_service/orders/room_number_entry' and return
    end

    @order.status = 1

    if @order.save
      redirect_to admin_room_service_orders_url
    end
  end

  private

  def reservation_params
    params.permit(:room_number)
  end
end