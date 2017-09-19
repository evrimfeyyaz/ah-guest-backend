class RenameReservationAssociationsToReservationUserAssociations < ActiveRecord::Migration[5.1]
  def change
    rename_table :reservation_associations, :reservation_user_associations
  end
end
