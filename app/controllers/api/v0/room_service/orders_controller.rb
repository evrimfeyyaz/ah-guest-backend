class Api::V0::RoomService::OrdersController < Api::V0::ApiController
  def index
    authorize order_scope.build
    load_orders
    render_orders_json or no_content
  end

  def create
    build_order
    authorize @order
    (save_order and send_admin_notification_email) or render_validation_error_json(@order)
  end

  private

  def load_orders
    @orders ||= order_scope.to_a
  end

  def build_order
    @order ||= order_scope.build
    @order.attributes = permitted_attributes(@order)
  end

  def save_order
    response.status = :created unless @order.persisted?
    render_order_json if @order.save
  end

  def render_order_json
    render json: @order,
           include: %w(cart_items cart_items.item cart_items.item.tags cart_items.item.choices cart_items.item.choices.options)
  end

  def render_orders_json
    if @orders.any?
      render json: @orders,
             include: %w(cart_items cart_items.item cart_items.item.tags cart_items.item.choices cart_items.item.choices.options)
    end
  end

  def send_admin_notification_email
    RoomService::OrderMailer.admin_notification(property: current_property, order: @order).deliver_now
  end

  def order_scope
    policy_scope(RoomService::Order).where(user_id: params[:user_id])
  end
end