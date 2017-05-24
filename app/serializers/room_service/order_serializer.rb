class RoomService::OrderSerializer < ActiveModel::Serializer
  attributes :id, :stay_id, :user_id

  has_many :cart_items
  class CartItemSerializer < ActiveModel::Serializer
    attributes :id, :quantity, :special_request, :room_service_item_id

    has_many :choices_for_options
    class ChoicesForOptionSerializer < ActiveModel::Serializer
      attributes :id, :room_service_option_id, :selected_choice_ids
    end
  end
end
