class RoomService::ItemChoice < ApplicationRecord
  has_many :options,
           foreign_key: 'room_service_item_choice_id',
           class_name: 'RoomService::ItemChoiceOption',
           dependent: :destroy, inverse_of: :choice
  has_and_belongs_to_many :items, inverse_of: :choices,
                          foreign_key: 'room_service_item_choice_id',
                          association_foreign_key: 'room_service_item_id'
  belongs_to :default_option,
             class_name: 'RoomService::ItemChoiceOption',
             optional: true

  validates_presence_of :title
  validates_length_of :title, maximum: 50
  validates_length_of :options, minimum: 2
end