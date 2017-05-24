require 'rails_helper'

describe 'POST /api/v0/users/:user_id/room-service/orders' do
  context 'with valid parameters' do
    it 'creates an order' do
      user = create(:user)
      stay = user.stays.create(attributes_for(:stay))

      item = create(:room_service_item_with_option)
      option = item.options.first
      selected_choice = option.possible_choices.first
      non_selected_choice = option.possible_choices.last

      cart_item_attributes = attributes_for(:room_service_cart_item)

      post "/api/v0/users/#{user.id}/room-service/orders", params: {
        'order' => {
          'stay_id' => stay.id,
          'cart_items_attributes' => {
            '0' => {
              'quantity' => cart_item_attributes[:quantity],
              'special_request' => cart_item_attributes[:special_request],
              'room_service_item_id' => item.id,
              'choices_for_options_attributes' => {
                '0' => {
                  'room_service_option_id' => option.id,
                  'selected_choice_ids' => [
                    selected_choice.id
                  ]
                }
              }
            }
          }
        }
      }.to_json, headers: json_headers

      expect(response.status).to eq(201)

      order = user.room_service_orders.last
      cart_item = order.cart_items.first
      choices_for_option = cart_item.choices_for_options.first

      expect(choices_for_option.option).to eq(option)
      expect(choices_for_option.selected_choices).to include(selected_choice)
      expect(choices_for_option.selected_choices).not_to include(non_selected_choice)

      expect(response_json).to eq({ 'id' => order.id,
                                    'stay_id' => stay.id,
                                    'user_id' => user.id,
                                    'cart_items' => [
                                      {
                                        'id' => cart_item.id,
                                        'quantity' => cart_item.quantity,
                                        'special_request' => cart_item.special_request,
                                        'room_service_item_id' => item.id,
                                        'choices_for_options' => [
                                          {
                                            'id' => choices_for_option.id,
                                            'room_service_option_id' => choices_for_option.option.id,
                                            'selected_choice_ids' => [
                                              choices_for_option.selected_choices.first.id
                                            ]
                                          }
                                        ]
                                      }
                                    ]
                                  })
    end
  end
end