class AddRoomServiceOrderReferenceToRoomServiceCartItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_cart_items, :room_service_order, foreign_key: true
  end
end
