class Admin::RoomService::OrdersController < AdminController
  def index
    load_orders
  end

  def show
    load_order
  end

  def complete
    load_order
    complete_order or render 'index'
  end

  private

  def load_orders
    @orders ||= order_scope.order(created_at: :desc).page params[:page]
  end

  def load_order
    @order ||= order_scope.find(params[:id])
  end

  def build_order
    @order ||= order_scope.build
    @order.attributes = permitted_attributes(@order)
  end

  def complete_order
    if @order.reservation.room_number.blank? && params[:room_number]
      @order.reservation.room_number = params[:room_number]
    end

    @order.status = 'complete'

    if @order.save
      redirect_to admin_room_service_orders_url
    end
  end

  def order_scope
    RoomService::Order.all
  end
end