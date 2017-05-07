class RoomService::Section < ApplicationRecord
  validates :title, presence: true
end
