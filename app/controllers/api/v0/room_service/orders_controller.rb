class Api::V0::RoomService::OrdersController < ApiController
  rescue_from ActionController::ParameterMissing, with: :respond_with_unprocessable_entity

  before_action :ensure_active_reservation, except: [:index]

  def index
    user = User.find(params[:user_id])

    if user != current_user
      return head :forbidden
    end

    if user.room_service_orders.count == 0
      return head :no_content
    else
      render json: user.room_service_orders,
             include: ['cart_items.choices_for_options',
                       'cart_items.item',
                       'cart_items.item.tags',
                       'cart_items.item.options',
                       'cart_items.item.options.possible_choices']
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
             include: ['cart_items.choices_for_options',
                       'cart_items.item',
                       'cart_items.item.tags',
                       'cart_items.item.options',
                       'cart_items.item.options.possible_choices']
    else
      render json: order, status: :unprocessable_entity, serializer: ValidationErrorSerializer
    end
  end

  private
  def ensure_active_reservation
    unless current_user.current_reservation
      render json: {
        'user' => [
          {
            'error' => 'has_no_active_reservation',
            'full_message' => 'You need an active reservation to do this action'
          }
        ]
      }, status: :forbidden, serializer: AuthorizationErrorSerializer

      false
    end
  end

  private

  def order_params
    params.require(:order).permit(:reservation_id,
                                  cart_items_attributes: [:quantity,
                                                          :special_request,
                                                          :room_service_item_id,
                                                          choices_for_options_attributes: [:room_service_option_id,
                                                                                           selected_choice_ids: []]])
  end

  def respond_with_unprocessable_entity
    head :unprocessable_entity
  end
end
