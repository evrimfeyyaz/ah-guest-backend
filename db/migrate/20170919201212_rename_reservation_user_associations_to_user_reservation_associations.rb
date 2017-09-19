class RenameReservationUserAssociationsToUserReservationAssociations < ActiveRecord::Migration[5.1]
  def change
    rename_table :reservation_user_associations, :user_reservation_associations
  end
end
