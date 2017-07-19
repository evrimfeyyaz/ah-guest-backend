class Api::V0::RoomService::OrdersController < ApiController
  rescue_from ActionController::ParameterMissing, with: :respond_with_unprocessable_entity

  def index
    load_user
    authorize @user, :current_user?
    load_orders
    render_orders_json or no_content
  end

  def create
    build_order
    authorize @order
    save_order or render_validation_error_json(@order)
  end

  private

  def respond_with_unprocessable_entity
    head :unprocessable_entity
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_orders
    @orders ||= policy_scope(RoomService::Order).to_a
  end

  def build_order
    @order ||= policy_scope(RoomService::Order).build
    @order.attributes = order_params
  end

  def save_order
    if @order.save
      response.status = :created
      render json: @order,
             include: ['cart_items',
                       'cart_items.item',
                       'cart_items.item.tags',
                       'cart_items.item.choices',
                       'cart_items.item.choices.options']
    end
  end

  def render_orders_json
    if @orders.any?
      render json: @orders,
             include: %w(cart_items cart_items.item cart_items.item.tags cart_items.item.choices cart_items.item.choices.options)
    end
  end

  def order_params
    params.require(:order).permit([:reservation_id,
                                   cart_items_attributes: [:quantity,
                                                           :special_request,
                                                           :room_service_item_id,
                                                           selected_option_ids: []]])
  end

  def no_content
    return head :no_content
  end

  def send_admin_notification_email
    # TODO: Refactor this.
    Time.use_zone('Riyadh') do
      mg_client = ::Mailgun::Client.new 'key-c8d28752e6f50c0e73cc6eb02c0a4918'
      message_params =  { from: 'notification@mail.automatedhotel.com',
                          to:   ENV['ORDER_NOTIFICATION_EMAIL'],
                          subject: "New Room Service Order \##{order.id}",
                          text:    "A new room service order has been placed on #{order.created_at.to_s(:short)}. Please check the system to see the details of the order."
      }
      mg_client.send_message 'mail.automatedhotel.com', message_params
    end unless Rails.env.development?
  end
end