FactoryGirl.define do
  factory :room_service_cart_item_selected_option_association, class: 'RoomService::CartItem::SelectedOptionAssociation' do
    association :cart_item, factory: :room_service_cart_item
    association :selected_option, factory: :room_service_item_choice_option
  end
end