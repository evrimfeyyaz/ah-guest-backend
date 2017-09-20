require 'rails_helper'

describe 'POST /api/v0/users/:user_id/room_service/orders' do
  it_behaves_like 'an endpoint that requires client secret authentication', :post, '/api/v0/users/0/room_service/orders'
  it_behaves_like 'an endpoint that requires user authentication', :post, '/api/v0/users/%{object_id}/room_service/orders' do
    let(:object) { user }
  end

  let(:user) { create(:user_with_reservation_including_current_day) }
  let(:reservation) { user.reservations.last }
  let(:item) { create(:room_service_item_with_choice_and_tag) }
  let(:tag) { item.tags.first }
  let(:choice) { item.choices.first }
  let(:selected_option) { choice.options.first }
  let(:unselected_option) { choice.options.last }
  let(:cart_item_attributes) { attributes_for(:room_service_cart_item, special_request: 'irrelevant',
                                              room_service_item_id: item.id, selected_option_ids: [selected_option.id]) }
  let(:order_attributes) { attributes_for(:room_service_order, payment_type: :room_account,
                                          reservation_id: reservation.id)}

  context 'with valid parameters' do
    it 'creates an order (201)' do
      post "/api/v0/users/#{user.id}/room_service/orders", params: {
        'room_service_order' => {
          'reservation_id' => order_attributes[:reservation_id],
          'payment_type' => order_attributes[:payment_type],
          'cart_items_attributes' => {
            '0' => {
              'quantity' => cart_item_attributes[:quantity],
              'special_request' => cart_item_attributes[:special_request],
              'room_service_item_id' => cart_item_attributes[:room_service_item_id],
              'selected_option_ids' => cart_item_attributes[:selected_option_ids]
            }
          }
        }
      }.to_json, headers: request_headers(user: user)

      expect(response.status).to eq(201)

      order = user.room_service_orders.last
      cart_item = order.cart_items.first

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
                                              'id' => item.tags.first.id,
                                              'title' => item.tags.first.title
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
    it 'does not create an order (422)' do
      unavailable_category = create(:room_service_category, available_from: 8.hours.ago, available_until: 1.hour.ago)
      item.category_section.category =  unavailable_category
      item.category_section.save!

      expect {
        post "/api/v0/users/#{user.id}/room_service/orders", params: {
          'room_service_order' => {
            'reservation_id' => reservation.id,
            'payment_type' => order_attributes[:payment_type],
            'cart_items_attributes' => {
              '0' => {
                'quantity' => cart_item_attributes[:quantity],
                'special_request' => cart_item_attributes[:special_request],
                'room_service_item_id' => cart_item_attributes[:room_service_item_id],
                'selected_option_ids' => cart_item_attributes[:selected_option_ids]
              }
            }
          }
        }.to_json, headers: request_headers(user: user)
      }.not_to change { RoomService::Order.count }

      available_from = item.available_from.strftime('%H:%M')
      available_until = item.available_until.strftime('%H:%M')

      expect(response.status).to eq(422)
      expect(response_json['error_type']).to eq('validation')
      expect(response_json['errors']).to include('cart_items.item' => [
        {
          'error' => 'not_available_at_the_moment',
          'title' => item.title,
          'id' => item.id,
          'available_from' => available_from,
          'available_until' => available_until,
          'full_message' => "Cart items item \"#{item.title}\" is not available at the moment (only available from #{available_from} to #{available_until})"
        }
      ])
    end
  end

  context 'when the user does not have an active reservation' do
    # TODO: Convert this to a shared example.
    it 'does not create an order (422)' do
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
    it 'returns the orders (200)' do
      order = create(:room_service_order, user: user, cart_items_count: 1)
      reservation = order.reservation
      cart_item = order.cart_items.first
      cart_item.item = create(:room_service_item_with_choice_and_tag)
      item = cart_item.item
      choice = item.choices.first
      selected_option = choice.options.first
      unselected_option = choice.options.last
      cart_item.selected_options << selected_option
      cart_item.save!
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
    it 'responds with no content (204)' do
      get "/api/v0/users/#{user.id}/room_service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(204)
    end
  end

  context 'when the user ID in the URL does not match the current user' do
    # TODO: Convert this to a shared example.
    it 'responds with forbidden (403)' do
      another_user = create(:user)

      get "/api/v0/users/#{another_user.id}/room_service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(403)
    end
  end
end