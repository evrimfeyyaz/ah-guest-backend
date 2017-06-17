class RoomService::ItemChoiceOption < ApplicationRecord
  belongs_to :choice, foreign_key: 'room_service_item_choice_id',
             inverse_of: :options, class_name: 'RoomService::ItemChoice'

  validates_presence_of :title
  validates_numericality_of :price, greater_than_or_equal_to: 0
end
