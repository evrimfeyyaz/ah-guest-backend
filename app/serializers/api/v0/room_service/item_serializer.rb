class Api::V0::RoomService::ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_description, :long_description, :price

  has_many :item_attributes, include_data: true
  class ItemAttributeSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  has_many :possible_options, include_data: true
  class ItemOptionSerializer < ActiveModel::Serializer
    attributes :id, :title, :optional, :allows_multiple_choices, :default_choice_id

    has_many :possible_choices, include_data: true
    class ItemOptionChoiceSerializer < ActiveModel::Serializer
      attributes :id, :title, :price
    end
  end
end
