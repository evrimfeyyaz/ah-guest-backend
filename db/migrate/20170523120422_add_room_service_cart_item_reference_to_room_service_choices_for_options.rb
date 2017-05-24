class AddRoomServiceCartItemReferenceToRoomServiceChoicesForOptions < ActiveRecord::Migration[5.1]
  def change
    add_reference :room_service_choices_for_options, :room_service_cart_item,
                  foreign_key: true, index: { name: 'room_service_choices_for_options_on_cart_item_id' }
  end
end
