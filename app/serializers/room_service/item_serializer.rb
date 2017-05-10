class RoomService::ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_description, :long_description, :price

  has_many :item_attributes, include_data: true
  class ItemAttributeSerializer < ActiveModel::Serializer
    attributes :id, :title
  end
end
