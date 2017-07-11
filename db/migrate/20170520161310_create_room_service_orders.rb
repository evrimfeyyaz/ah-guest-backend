class CreateRoomServiceOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_orders do |t|
      t.timestamps
    end
  end
end
