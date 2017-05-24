class RoomService::Choice < ApplicationRecord
  belongs_to :option, foreign_key: 'room_service_option_id', inverse_of: :possible_choices

  validates_presence_of :title
  validates_numericality_of :price, greater_than_or_equal_to: 0
end
