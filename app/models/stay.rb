class Stay < ApplicationRecord
  belongs_to  :user, inverse_of: :stays
  has_many    :room_service_orders, class_name: 'RoomService::Order', inverse_of: :stay
end