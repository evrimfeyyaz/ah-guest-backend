class Api::V0::RoomService::OrdersController < ApiController
  rescue_from ActionController::ParameterMissing, with: :respond_with_unprocessable_entity

  def index
    user = User.find(params[:user_id])

    if user != current_user
      return head :forbidden
    end

    if user.room_service_orders.count == 0
      return head :no_content
    else
      render json: user.room_service_orders,
             include: ['cart_items',
                       'cart_items.item',
                       'cart_items.item.tags',
                       'cart_items.item.choices',
                       'cart_items.item.choices.options']
    end
  end

  def create
    if params[:order].include?(:user_id)
      return head :forbidden
    end

    user = User.find(params[:user_id])

    if user != current_user
      return head :forbidden
    end

    reservation_id = order_params[:reservation_id]
    unless reservation_id.nil? || user.reservation_ids.include?(reservation_id)
      return head :forbidden
    end

    order = user.room_service_orders.build(order_params)

    if order.save
      render json: order, status: :created,
             include: ['cart_items',
                       'cart_items.item',
                       'cart_items.item.tags',
                       'cart_items.item.choices',
                       'cart_items.item.choices.options']
    else
      render json: order, status: :unprocessable_entity, serializer: ValidationErrorSerializer
    end
  end

  private

  def order_params
    params.require(:order).permit(:reservation_id,
                                  cart_items_attributes: [:quantity,
                                                          :special_request,
                                                          :room_service_item_id,
                                                          selected_option_ids: []])
  end

  def respond_with_unprocessable_entity
    head :unprocessable_entity
  end
end
