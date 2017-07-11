class RenameNameToFirstNameInReservations < ActiveRecord::Migration[5.1]
  def change
    rename_column :reservations, :name, :first_name
  end
end
