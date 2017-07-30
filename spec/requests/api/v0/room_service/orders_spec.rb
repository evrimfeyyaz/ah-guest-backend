require 'rails_helper'

describe 'POST /api/v0/users/:user_id/room_service/orders' do
  it_behaves_like 'an endpoint that requires client secret authentication', :post, '/api/v0/users/0/room_service/orders'
  it_behaves_like 'an endpoint that requires user authentication', :post, '/api/v0/users/%{object_id}/room_service/orders' do
    let(:object) { user }
  end

  let(:user) { create(:user) }

  context 'with valid parameters' do
    it 'creates an order' do
      reservation = user.reservations.create(attributes_for(:reservation_including_current_day))

      tag = create(:room_service_tag)
      item = create(:room_service_item_with_optional_choice, tags: [tag])
      choice = item.choices.first
      selected_option = choice.options.first
      unselected_option = choice.options.last

      cart_item_attributes = attributes_for(:room_service_cart_item)

      post "/api/v0/users/#{user.id}/room_service/orders", params: {
        'room_service_order' => {
          'reservation_id' => reservation.id,
          'payment_type' => 0,
          'cart_items_attributes' => {
            '0' => {
              'quantity' => cart_item_attributes[:quantity],
              'special_request' => cart_item_attributes[:special_request],
              'room_service_item_id' => item.id,
              'selected_option_ids' => [selected_option.id]
            }
          }
        }
      }.to_json, headers: request_headers(user: user)

      expect(response.status).to eq(201)

      order = user.room_service_orders.last
      cart_item = order.cart_items.first

      expect(cart_item.selected_options).to include(selected_option)
      expect(cart_item.selected_options).not_to include(unselected_option)

      expect(response_json).to eq({ 'id' => order.id,
                                    'reservation_id' => reservation.id,
                                    'payment_type' => order.payment_type,
                                    'user_id' => user.id,
                                    'cart_items' => [
                                      {
                                        'id' => cart_item.id,
                                        'quantity' => cart_item.quantity,
                                        'special_request' => cart_item.special_request,
                                        'item' => {
                                          'id' => item.id,
                                          'title' => item.title,
                                          'price' => item.price.to_s,
                                          'short_description' => item.short_description,
                                          'description' => item.description,
                                          'tags' => [
                                            {
                                              'id' => tag.id,
                                              'title' => tag.title
                                            }
                                          ],
                                          'choices' => [
                                            {
                                              'id' => choice.id,
                                              'title' => choice.title,
                                              'optional' => choice.optional,
                                              'allows_multiple_options' => choice.allows_multiple_options,
                                              'default_option_id' => choice.default_option_id,
                                              'options' => [
                                                {
                                                  'id' => selected_option.id,
                                                  'title' => selected_option.title,
                                                  'price' => selected_option.price.to_s
                                                },
                                                {
                                                  'id' => unselected_option.id,
                                                  'title' => unselected_option.title,
                                                  'price' => unselected_option.price.to_s
                                                }
                                              ]
                                            }
                                          ]
                                        },
                                        'selected_option_ids' => [selected_option.id]
                                      }
                                    ]
                                  })
    end
  end

  context 'when the order includes an item that is not available at the time of creation' do
    it 'does not create an order and responds with "422 Unprocessable Entity"' do
      reservation = user.reservations.create(attributes_for(:reservation_including_current_day))

      category = create(:room_service_category, available_from: 8.hours.ago, available_until: 1.hour.ago)
      item = create(:room_service_item_with_optional_choice, sub_category: category.default_sub_category)
      choice = item.choices.first
      selected_option = choice.options.first

      cart_item_attributes = attributes_for(:room_service_cart_item)

      expect {
        post "/api/v0/users/#{user.id}/room_service/orders", params: {
          'room_service_order' => {
            'reservation_id' => reservation.id,
            'payment_type' => 0,
            'cart_items_attributes' => {
              '0' => {
                'quantity' => cart_item_attributes[:quantity],
                'special_request' => cart_item_attributes[:special_request],
                'room_service_item_id' => item.id,
                'selected_option_ids' => [selected_option.id]
              }
            }
          }
        }.to_json, headers: request_headers(user: user)
      }.not_to change { RoomService::Order.count }

      available_from_time_only = item.available_from.utc.strftime('%H:%M')
      available_until_time_only = item.available_until.utc.strftime('%H:%M')

      available_from_local_time_only = item.available_from.in_time_zone('Riyadh').strftime('%H:%M')
      available_until_local_time_only = item.available_until.in_time_zone('Riyadh').strftime('%H:%M')

      expect(response.status).to eq(422)
      expect(response_json['error_type']).to eq('validation')
      expect(response_json['errors']).to include('cart_items.item' => [
        {
          'error' => 'not_available_at_the_moment',
          'title' => item.title,
          'id' => item.id,
          'available_from_utc' => available_from_time_only,
          'available_until_utc' => available_until_time_only,
          'available_from_local' => available_from_local_time_only,
          'available_until_local' => available_until_local_time_only,
          'full_message' => "Cart items item \"#{item.title}\" is not available at the moment (only available from #{available_from_local_time_only} to #{available_until_local_time_only} in local time)"
        }
      ])
    end
  end

  context 'when the user does not have an active reservation' do
    it 'does not create an order and responds with "422 Unprocessable Entity"' do
      past_reservation = create(:reservation, check_in_date: 2.days.ago, check_out_date: 1.day.ago)
      user.reservations << past_reservation

      expect {
        post "/api/v0/users/#{user.id}/room_service/orders", headers: request_headers(user: user)
      }.not_to change { RoomService::Order.count }

      expect(response.status).to eq(422)
    end
  end
end

describe 'GET /api/v0/users/:user_id/room_service/orders' do
  it_behaves_like 'an endpoint that requires client secret authentication', :get, '/api/v0/users/0/room_service/orders'
  it_behaves_like 'an endpoint that requires user authentication', :get, '/api/v0/users/%{object_id}/room_service/orders' do
    let(:object) { user }
  end

  let(:user) { create(:user) }

  context 'when user has orders' do
    it 'returns orders and responds with "200 OK"' do
      order = create(:room_service_order, user: user, cart_items_count: 1)
      reservation = order.reservation
      cart_item = order.cart_items.first
      cart_item.item = create(:room_service_item_with_choice_and_tag)
      item = cart_item.item
      choice = item.choices.first
      selected_option = choice.options.first
      unselected_option = choice.options.last
      cart_item.selected_options << selected_option
      cart_item.save
      tag = item.tags.first

      get "/api/v0/users/#{user.id}/room_service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(200)
      expect(response_json).to eq([
                                    { 'id' => order.id,
                                      'reservation_id' => reservation.id,
                                      'payment_type' => order.payment_type,
                                      'user_id' => user.id,
                                      'cart_items' => [
                                        {
                                          'id' => cart_item.id,
                                          'quantity' => cart_item.quantity,
                                          'special_request' => cart_item.special_request,
                                          'item' => {
                                            'id' => item.id,
                                            'title' => item.title,
                                            'price' => item.price.to_s,
                                            'short_description' => item.short_description,
                                            'description' => item.description,
                                            'tags' => [
                                              {
                                                'id' => tag.id,
                                                'title' => tag.title
                                              }
                                            ],
                                            'choices' => [
                                              {
                                                'id' => choice.id,
                                                'title' => choice.title,
                                                'optional' => choice.optional,
                                                'allows_multiple_options' => choice.allows_multiple_options,
                                                'default_option_id' => choice.default_option_id,
                                                'options' => [
                                                  {
                                                    'id' => selected_option.id,
                                                    'title' => selected_option.title,
                                                    'price' => selected_option.price.to_s
                                                  },
                                                  {
                                                    'id' => unselected_option.id,
                                                    'title' => unselected_option.title,
                                                    'price' => unselected_option.price.to_s
                                                  }
                                                ]
                                              }
                                            ]
                                          },
                                          'selected_option_ids' => [selected_option.id]
                                        }
                                      ]
                                    }
                                  ])
    end
  end

  context 'when user does not have orders' do
    it 'responds with "204 No Content"' do
      get "/api/v0/users/#{user.id}/room_service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(204)
    end
  end

  context 'when the user ID in the URL does not match the current user' do
    it 'responds with "403 Forbidden"' do
      another_user = create(:user)

      get "/api/v0/users/#{another_user.id}/room_service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(403)
    end
  end
end