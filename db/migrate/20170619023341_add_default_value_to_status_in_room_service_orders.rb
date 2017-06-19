class AddDefaultValueToStatusInRoomServiceOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :room_service_orders, :status, :integer, limit: 1, default: 0
  end
end
