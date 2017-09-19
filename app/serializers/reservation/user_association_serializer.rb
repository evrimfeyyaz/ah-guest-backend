class Reservation::UserAssociationSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  belongs_to :reservation
end