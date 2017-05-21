require 'rails_helper'

describe 'POST /api/v0/users/:user_id/room-service/orders' do
  let(:json_headers) { { 'CONTENT_TYPE' => 'application/json' } }

  context 'with valid parameters' do
    it 'creates an order' do
      user = create(:user)
      # stay = user.stays.create(attributes_for(:stay))

      item = create(:room_service_item)

      option = create(:room_service_item_option_with_choices, choices_count: 2)
      choice1 = option.possible_choices.first
      choice2 = option.possible_choices.last

      item.possible_options << option

      cart_item_attributes = attributes_for(:room_service_cart_item)
      cart_item_attributes[:client_generated_id] = SecureRandom.uuid

      client_generated_id_for_choices_for_option = SecureRandom.uuid

      post "/api/v0/users/#{user.id}/room-service/orders", params: {
        'data' => {
          'type' => 'room-service-orders',
          'relationships' => {
            'cart-items' => {
              'data' => [
                {
                  'type' => 'room-service-cart-items',
                  'id' => cart_item_attributes[:client_generated_id]
                }
              ]
            }
          }
        },
        'included' => [
          {
            'type' => 'room-service-cart-items',
            'id' => cart_item_attributes[:client_generated_id],
            'attributes' => {
              'quantity' => cart_item_attributes[:quantity],
              'special-request' => cart_item_attributes[:special_request]
            },
            'relationships' => {
              'item' => {
                'data' => {
                  'type' => 'room-service-items',
                  'id' => item.id.to_s
                }
              },
              'choices-for-options' => {
                'data' => [
                  {
                    'type' => 'room-service-item-choices-for-options',
                    'id' => client_generated_id_for_choices_for_option
                  }
                ]
              }
            }
          },
          {
            'type' => 'room-service-item-choices-for-options',
            'id' => client_generated_id_for_choices_for_option,
            'relationships' => {
              'option' => {
                'data' => {
                  'type' => 'room-service-item-options',
                  'id' => option.id.to_s
                }
              },
              'selected-choices' => {
                'data' => [
                  {
                    'type' => 'room-service-item-option-choices',
                    'id' => choice1.id.to_s
                  }
                ]
              }
            }
          }
        ]
      }.to_json, headers: json_headers

      expect(response.status).to eq(201)

      order = user.room_service_orders.last
      cart_item = order.cart_items.first
      choices_for_option = cart_item.choices_for_options.first

      expect(choices_for_option.selected_choices).to include(choice1)
      expect(choices_for_option.selected_choices).not_to include(choice2)

      expect(response_json).to eq('data' =>
                                    {
                                      'type' => 'room-service-orders',
                                      'id' => order.id.to_s,
                                      'relationships' => {
                                        'cart-items' => {
                                          'data' => [
                                            {
                                              'type' => 'room-service-cart-items',
                                              'id' => cart_item.id.to_s
                                            }
                                          ]
                                        },
                                        'user' => {
                                          'data' => {
                                            'type' => 'users',
                                            'id' => user.id.to_s
                                          }
                                        }
                                      }
                                    })
    end
  end
end