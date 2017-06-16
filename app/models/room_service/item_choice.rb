class RoomService::ItemChoice < ApplicationRecord
  has_many :possible_options,
           foreign_key: 'room_service_item_choice_id',
           class_name: 'ItemChoiceOption',
           dependent: :destroy, inverse_of: :choice
  has_and_belongs_to_many :items, inverse_of: :choices,
                          foreign_key: 'room_service_item_choice_id',
                          association_foreign_key: 'room_service_item_id'
  belongs_to :default_option,
             class_name: 'RoomService::ItemChoiceOption',
             foreign_key: 'default_room_service_item_choice_option_id',
             optional: true

  validates_presence_of :title
end
