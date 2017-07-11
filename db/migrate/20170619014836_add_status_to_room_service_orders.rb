class AddStatusToRoomServiceOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_orders, :status, :integer, limit: 1
  end
end
