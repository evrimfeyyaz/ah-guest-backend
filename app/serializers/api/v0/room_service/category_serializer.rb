class Api::V0::RoomService::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_urls
end
