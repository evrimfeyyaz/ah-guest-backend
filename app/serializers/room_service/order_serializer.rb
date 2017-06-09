class RoomService::OrderSerializer < ActiveModel::Serializer
  attributes :id, :reservation_id, :user_id

  has_many :cart_items
  class CartItemSerializer < ActiveModel::Serializer
    attributes :id, :quantity, :special_request

    belongs_to :item

    has_many :choices_for_options
    class ChoicesForOptionSerializer < ActiveModel::Serializer
      attributes :id, :room_service_option_id, :selected_choice_ids
    end
  end
end
