class Api::V0::RoomService::OrdersController < ApiController
  rescue_from ActionController::ParameterMissing, with: :respond_with_unprocessable_entity

  def create
    user = User.find(params[:user_id])

    if user != current_user
      return head :unauthorized
    end

    reservation_id = params[:order][:reservation_id]
    unless reservation_id.nil? || user.reservation_ids.include?(reservation_id)
      return head :unauthorized
    end

    order = user.room_service_orders.build(order_params)

    if order.save
      render json: order, status: :created, include: ['cart_items.choices_for_options']
    else
      render json: order, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
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
