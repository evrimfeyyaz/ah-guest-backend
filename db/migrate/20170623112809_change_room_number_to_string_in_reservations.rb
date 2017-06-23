class ChangeRoomNumberToStringInReservations < ActiveRecord::Migration[5.1]
  def change
    change_column :reservations, :room_number, :string
  end
end
