class Api::V0::RoomService::OrdersController < ActionController::API
  def create
    p order_params
    user = User.find(params[:user_id])

    order = user.room_service_orders.build(order_params)

    if order.save
      render json: order, status: :created
    else
      render json: order, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

  def order_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: ['cart-items'])
  end
end
