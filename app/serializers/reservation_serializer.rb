class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :check_in_date, :check_out_date, :confirmation_code, :room_number
end