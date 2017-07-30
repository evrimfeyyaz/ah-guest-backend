class Api::V0::RoomService::OrdersController < ApiController
  def index
    authorize order_scope.build
    load_orders
    render_orders_json or no_content
  end

  def create
    build_order
    authorize @order
    save_order or render_validation_error_json(@order)
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
    # TODO: Refactor this.
    Time.use_zone('Riyadh') do
      mg_client = ::Mailgun::Client.new 'key-c8d28752e6f50c0e73cc6eb02c0a4918'
      message_params = { from: 'notification@mail.automatedhotel.com',
                         to: ENV['ORDER_NOTIFICATION_EMAIL'],
                         subject: "New Room Service Order \##{order.id}",
                         text: "A new room service order has been placed on #{order.created_at.to_s(:short)}. Please check the system to see the details of the order."
      }
      mg_client.send_message 'mail.automatedhotel.com', message_params
    end unless Rails.env.development?
  end

  def order_scope
    policy_scope(RoomService::Order).where(user_id: params[:user_id])
  end
end