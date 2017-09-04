class RoomService::ItemChoice < ApplicationRecord
  has_many :options,
           foreign_key: 'room_service_item_choice_id',
           class_name: 'RoomService::ItemChoiceOption',
           dependent: :destroy, inverse_of: :choice
  belongs_to :default_option,
             class_name: 'RoomService::ItemChoiceOption',
             optional: true
  has_many :item_choice_associations, class_name: 'RoomService::Item::ChoiceAssociation', inverse_of: :choice
  has_many :items, through: :item_choice_associations

  validates_presence_of :title
  validates_length_of :title, maximum: 50
  validates_length_of :options, minimum: 2
end