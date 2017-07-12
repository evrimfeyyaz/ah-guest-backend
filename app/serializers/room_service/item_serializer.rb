class RoomService::ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :short_description, :description

  has_many :tags
  class TagSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  has_many :choices
  class ItemChoiceSerializer < ActiveModel::Serializer
    attributes :id, :title, :optional, :allows_multiple_options, :default_option_id

    has_many :options
    class ItemChoiceOptionSerializer < ActiveModel::Serializer
      attributes :id, :title, :price
    end
  end
end
