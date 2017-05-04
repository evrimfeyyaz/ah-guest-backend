class RoomService::Category < ApplicationRecord
  validates :title, presence: true
end
