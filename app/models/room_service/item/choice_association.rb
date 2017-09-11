class RoomService::Item::ChoiceAssociation < ApplicationRecord
  belongs_to :item, class_name: 'RoomService::Item', foreign_key: 'room_service_item_id'
  belongs_to :choice, class_name: 'RoomService::Item::Choice', foreign_key: 'room_service_item_choice_id'
end