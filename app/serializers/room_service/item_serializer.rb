class RoomService::ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :short_description, :long_description

  has_many :item_attributes
  class ItemAttributeSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  has_many :options
  class OptionSerializer < ActiveModel::Serializer
    attributes :id, :title, :optional, :allows_multiple_choices, :default_room_service_choice_id

    has_many :possible_choices
    class ChoiceSerializer < ActiveModel::Serializer
      attributes :id, :title, :price
    end
  end
end
