class RoomService::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_urls
end
