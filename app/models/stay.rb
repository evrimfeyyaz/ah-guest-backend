class Stay < ApplicationRecord
  belongs_to  :user, inverse_of: :stays, optional: true
  has_many    :room_service_orders, class_name: 'RoomService::Order', inverse_of: :stay
end