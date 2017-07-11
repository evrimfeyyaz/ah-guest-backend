class RenameStayIdToReservationIdInRoomServiceOrders < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_service_orders, :stay_id, :reservation_id
  end
end
