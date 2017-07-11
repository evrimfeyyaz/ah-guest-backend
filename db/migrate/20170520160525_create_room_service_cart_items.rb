class CreateRoomServiceCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_cart_items do |t|
      t.integer :quantity
      t.text :special_request
      t.references :room_service_item, foreign_key: true

      t.timestamps
    end
  end
end
