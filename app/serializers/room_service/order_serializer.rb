class RoomService::OrderSerializer < ActiveModel::Serializer
  attributes :id, :reservation_id, :user_id, :payment_type

  has_many :cart_items
  class CartItemSerializer < ActiveModel::Serializer
    attributes :id, :quantity, :special_request, :selected_option_ids

    belongs_to :item
  end
end