class RoomService::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description
end
