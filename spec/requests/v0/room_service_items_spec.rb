require 'rails_helper'

describe 'GET /v0/room-service/items/:item_id' do
  let(:category) { create(:room_service_category) }
  let(:item) { category.default_section.items.create(attributes_for(:room_service_item)) }

  it 'returns a room service item' do
    get "/v0/room-service/items/#{item.id}"

    expect(response_json).to eq('data' =>
                                  {
                                    'id' => item.id.to_s,
                                    'type' => 'room-service-items',
                                    'attributes' => {
                                      'title' => item.title,
                                      'short-description' => item.short_description,
                                      'long-description' => item.long_description,
                                      'price' => item.price.to_s
                                    },
                                    'relationships' => {
                                      'item-attributes' => {
                                        'data' => []
                                      }
                                    }
                                  })
  end

  it 'returns the room service item attributes when the room service item has at least one attribute' do
    attribute = item.item_attributes.create(attributes_for(:room_service_item_attribute))

    get "/v0/room-service/items/#{item.id}"

    # TODO: Find a way to refactor out the serialized object type.
    expect(response_json['data']['relationships']).to include('item-attributes' =>
                                                                {
                                                                  'data' =>
                                                                    [
                                                                      {
                                                                        'id' => attribute.id.to_s,
                                                                        'type' => 'room-service-item-attributes'
                                                                      }
                                                                    ]
                                                                })
    expect(response_json['included']).to include('id' => attribute.id.to_s,
                                                 'type' => 'room-service-item-attributes',
                                                 'attributes' => {
                                                   'title' => attribute.title
                                                 })
  end

  it 'returns the room service item options (and the associated choices) when the room service item has at least one option'
end