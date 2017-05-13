class RoomService::ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_description, :long_description, :price

  has_many :item_attributes, include_data: true
  class ItemAttributeSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  has_many :possible_options, include_data: true
  class ItemOptionSerializer < ActiveModel::Serializer
    attributes :id, :title, :optional, :allows_multiple_choices

    has_many :possible_choices, include_data: true
    belongs_to :default_choice, include_data: true, type: 'room-service-item-option-choices'
    class ItemOptionChoiceSerializer < ActiveModel::Serializer
      attributes :id, :title, :price
    end
  end
end
