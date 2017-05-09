class RoomService::ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_description, :long_description, :price
end
