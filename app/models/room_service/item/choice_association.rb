class RoomService::Item::ChoiceAssociation < ApplicationRecord
  belongs_to :item, foreign_key: 'room_service_item_id'
  belongs_to :choice, foreign_key: 'room_service_item_choice_id'

  validates_uniqueness_of :choice, scope: :room_service_item_id
end