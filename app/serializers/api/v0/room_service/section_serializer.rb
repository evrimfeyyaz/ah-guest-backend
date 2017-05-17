class Api::V0::RoomService::SectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :default

  has_many :items, include_data: true
  class ItemSerializer < ActiveModel::Serializer
    attributes :id, :title, :short_description, :price
  end
end
