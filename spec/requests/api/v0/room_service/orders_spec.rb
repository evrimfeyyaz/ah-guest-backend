require 'rails_helper'

describe 'POST /api/v0/users/:user_id/room-service/orders' do
  it_behaves_like 'an endpoint that requires client secret authorization', :post, '/api/v0/users/0/room-service/orders'
  it_behaves_like 'an endpoint that requires user authentication', :post, "/api/v0/users/%{user_id}/room-service/orders" do
    let(:user) { create(:user) }
  end

  let(:user) { create(:user) }

  context 'with valid parameters' do
    it 'creates an order' do
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
      }.to_json, headers: request_headers(user: user)

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

  context 'with a user ID parameter different than the one of the current user' do
    it 'wrong user ID is ignored' do
      wrong_user = create(:user)

      stay = user.stays.create(attributes_for(:stay))

      item = create(:room_service_item_with_option)
      cart_item_attributes = attributes_for(:room_service_cart_item)

      expect {
        post "/api/v0/users/#{user.id}/room-service/orders", params: {
          'order' => {
            'stay_id' => stay.id,
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

  context 'with a stay ID parameter that does not belong to the current user' do
    it 'responds with "401 Unauthorized"' do
      stay_that_belongs_to_another_user = create(:stay)

      post "/api/v0/users/#{user.id}/room-service/orders", params: {
        'order' => {
          'stay_id' => stay_that_belongs_to_another_user.id
        }
      }.to_json, headers: request_headers(user: user)

      expect(response.status).to eq(401)
    end
  end

  context 'with a user ID in the URL that does not belong to the current user' do
    it 'responds with "401 Unauthorized"' do
      wrong_user = create(:user)

      post "/api/v0/users/#{wrong_user.id}/room-service/orders", headers: request_headers(user: user)

      expect(response.status).to eq(401)
    end
  end
end