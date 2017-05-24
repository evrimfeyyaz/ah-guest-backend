class RoomService::SectionSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :items
  class ItemSerializer < ActiveModel::Serializer
    attributes :id, :title, :price, :short_description
  end
end