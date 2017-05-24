class Api::V0::RoomService::OrdersController < ActionController::API
  def create
    p params
    p order_params
    user = User.find(params[:user_id])

    order = user.room_service_orders.build(order_params)

    if order.save
      render json: order, status: :created, include: ['cart_items.choices_for_options']
    else
      render json: order, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

  def order_params
    params.require(:order).permit(:stay_id,
                                  cart_items_attributes: [:quantity,
                                                          :special_request,
                                                          :room_service_item_id,
                                                          choices_for_options_attributes: [:room_service_option_id,
                                                                                           selected_choice_ids: []]])
  end
end
