class Reservation::UserAssociation < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates_uniqueness_of :reservation, scope: :user_id
end