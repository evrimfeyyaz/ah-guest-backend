class RoomService::SelectedOptionsForCartItems < ApplicationRecord
  belongs_to :cart_item, class_name: 'RoomService::CartItem'
  belongs_to :selected_option, foreign_key: 'item_choice_option_id', class_name: 'RoomService::ItemChoiceOption'
end