class RoomService::OrderSerializer < ActiveModel::Serializer
  attributes :id

  has_many :cart_items, include_data: true
  class CartItemSerializer < ActiveModel::Serializer
    attributes :id, :quantity, :special_request
  end
end
