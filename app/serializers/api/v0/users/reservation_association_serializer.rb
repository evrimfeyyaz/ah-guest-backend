class Api::V0::Users::ReservationAssociationSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  belongs_to :reservation
end