class RoomService::Item::Choice < ApplicationRecord
  has_many :options, foreign_key: 'room_service_item_choice_id',
           dependent: :destroy, inverse_of: :choice
  belongs_to :default_option,
             class_name: 'RoomService::Item::Choice::Option',
             optional: true
  has_many :item_choice_associations, class_name: 'RoomService::Item::ChoiceAssociation',
           inverse_of: :choice, foreign_key: 'room_service_item_choice_id'
  has_many :items, through: :item_choice_associations

  validates_presence_of :title
  validates_length_of :title, maximum: 50
  validates_length_of :options, minimum: 2
end