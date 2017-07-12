class RenameStaysToReservations < ActiveRecord::Migration[5.1]
  def change
    rename_table :stays, :reservations
  end
end
