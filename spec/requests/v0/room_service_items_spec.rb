require 'rails_helper'

describe 'GET /v0/room-service/items/:item_id' do
  it 'returns a room service item' do
    category = create(:room_service_category)
    item = category.default_section.items.create(attributes_for(:room_service_item))

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
                                    }
                                  })
  end

  it 'returns the room service item attributes when the room service item has at least one of it'

  it 'returns the room service item options (and the associated choices) when the room service item has at least one of it'
end