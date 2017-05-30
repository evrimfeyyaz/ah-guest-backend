require 'rails_helper'

describe 'POST /api/v0/users/:user_id/room_service/orders' do
  it_behaves_like 'an endpoint that requires client secret authorization', :post, '/api/v0/users/0/room_service/orders'
  it_behaves_like 'an endpoint that requires user authentication', :post, '/api/v0/users/%{object_id}/room_service/orders' do
    let(:object) { user }
  end

  let(:user) { create(:user) }

  context 'with valid parameters' do
    it 'creates an order' do
      reservation = user.reservations.create(attributes_for(:reservation))

      item = create(:room_service_item_with_option)
      option = item.options.first
      selected_choice = option.possible_choices.first
      non_selected_choice = option.possible_choices.last

      cart_item_attributes = attributes_for(:room_service_cart_item)

      post "/api/v0/users/#{user.id}/room_service/orders", params: {
        'order' => {
          'reservation_id' => reservation.id,
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
      }.to_json, headers: request_headers(user: user)

      expect(response.status).to eq(201)

      order = user.room_service_orders.last
      cart_item = order.cart_items.first
      choices_for_option = cart_item.choices_for_options.first

      expect(choices_for_option.option).to eq(option)
      expect(choices_for_option.selected_choices).to include(selected_choice)
      expect(choices_for_option.selected_choices).not_to include(non_selected_choice)

      expect(response_json).to eq({ 'id' => order.id,
                                    'reservation_id' => reservation.id,
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

  context 'with a user ID parameter different than the one of the current user' do
    it 'wrong user ID is ignored' do
      wrong_user = create(:user)

      reservation = user.reservations.create(attributes_for(:reservation))

      item = create(:room_service_item_with_option)
      cart_item_attributes = attributes_for(:room_service_cart_item)

      expect {
        post "/api/v0/users/#{user.id}/room_service/orders", params: {
          'order' => {
            'reservation_id' => reservation.id,
            'user_id' => wrong_user.id,
            'cart_items_attributes' => {
              '0' => {
                'quantity' => cart_item_attributes[:quantity],
                'special_request' => cart_item_attributes[:special_request],
                'room_service_item_id' => item.id,
              }
            }
          }
        }.to_json, headers: request_headers(user: user)
      }.to change { user.room_service_orders.count }.by(1).
        and change { wrong_user.room_service_orders.count }.by(0)
    end
  end

  context 'with a reservation ID parameter that does not belong to the current user' do
    it 'responds with "400 Bad Request"' do
      reservation_that_belongs_to_another_user = create(:reservation)

      post "/api/v0/users/#{user.id}/room_service/orders", params: {
        'order' => {
          'reservation_id' => reservation_that_belongs_to_another_user.id
        }
      }.to_json, headers: request_headers(user: user)

      expect(response.status).to eq(400)
    end
  end

  context 'with a user ID in the URL that does not belong to the current user' do
    it 'responds with "403 Forbidden"' do
      wrong_user = create(:user)

      post "/api/v0/users/#{wrong_user.id}/room_service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(403)
    end
  end

  context 'when there is an item that is not available at the time of creation' do
    it 'does not create an order and responds with "422 Unprocessable Entity"' do
      reservation = user.reservations.create(attributes_for(:reservation))

      category = create(:room_service_category, available_from: 8.hours.ago, available_until: 1.hour.ago)
      item = create(:room_service_item_with_option, section: category.default_section)
      option = item.options.first
      selected_choice = option.possible_choices.first

      cart_item_attributes = attributes_for(:room_service_cart_item)

      expect {
        post "/api/v0/users/#{user.id}/room_service/orders", params: {
          'order' => {
            'reservation_id' => reservation.id,
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
        }.to_json, headers: request_headers(user: user)
      }.not_to change { RoomService::Order.count }

      expect(response.status).to eq(422)
      expect(response_json['error_type']).to eq('validation')
      expect(response_json['errors']).to include({ 'cart_items.base' => [{
                                                                           'error' => 'not_available_at_the_moment',
                                                                           'title' => item.title,
                                                                           'message' => "\"#{item.title}\" is not available at the moment"
                                                                         }] })
    end
  end
end

describe 'GET /api/v0/users/:user_id/room_service/orders' do
  it_behaves_like 'an endpoint that requires client secret authorization', :get, '/api/v0/users/0/room_service/orders'
  it_behaves_like 'an endpoint that requires user authentication', :get, '/api/v0/users/%{object_id}/room_service/orders' do
    let(:object) { user }
  end

  let(:user) { create(:user) }

  context 'when user has orders' do
    it 'returns orders and responds with "200 OK"' do
      order = create(:room_service_order_with_cart_items, user: user, cart_items_count: 1)
      cart_item = order.cart_items.first

      get "/api/v0/users/#{user.id}/room_service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(200)
      expect(response_json).to eq([{
                                     'id' => order.id,
                                     'reservation_id' => order.reservation_id,
                                     'user_id' => order.user_id,
                                     'cart_items' => [{ 'id' => cart_item.id,
                                                        'quantity' => cart_item.quantity,
                                                        'special_request' => cart_item.special_request,
                                                        'room_service_item_id' => cart_item.item.id }]
                                   }])
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