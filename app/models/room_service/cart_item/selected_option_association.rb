class RoomService::CartItem::SelectedOptionAssociation < ApplicationRecord
  belongs_to :cart_item, foreign_key: 'room_service_cart_item_id', class_name: 'RoomService::CartItem'
  belongs_to :selected_option, foreign_key: 'room_service_item_choice_option_id', class_name: 'RoomService::Item::Choice::Option'

  validates_uniqueness_of :selected_option, scope: :room_service_cart_item_id
end