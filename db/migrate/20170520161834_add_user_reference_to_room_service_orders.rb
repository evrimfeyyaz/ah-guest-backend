class AddUserReferenceToRoomServiceOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_orders, :user, foreign_key: true
  end
end
