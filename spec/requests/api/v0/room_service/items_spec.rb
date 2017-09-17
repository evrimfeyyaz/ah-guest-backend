require 'rails_helper'

describe 'GET /api/v0/room_service/items/:item_id' do
  it_behaves_like 'an endpoint that requires client secret authentication', :get, '/api/v0/room_service/items/0'

  let(:item) { create(:room_service_item) }

  context 'when item exists' do
    it 'returns a room service item' do
      get "/api/v0/room_service/items/#{item.id}", headers: request_headers

      expect(response.status).to eq(200)
      expect(response_json).to eq({
                                    'id' => item.id,
                                    'title' => item.title,
                                    'short_description' => item.short_description,
                                    'description' => item.description,
                                    'price' => item.price.to_s,
                                    'tags' => [],
                                    'choices' => []
                                  })
    end
  end

  context 'when item does not exist' do
    it 'responds with 404' do
      non_existent_item_id = 123456

      get "/api/v0/room_service/items/#{non_existent_item_id}", headers: request_headers

      expect(response.status).to be(404)
    end
  end

  context 'when item has tags' do
    it 'includes the tags' do
      attribute = item.tags.create(attributes_for(:room_service_tag))

      get "/api/v0/room_service/items/#{item.id}", headers: request_headers

      # noinspection RubyResolve
      expect(response_json).to include('tags' => [{
                                                    'id' => attribute.id,
                                                    'title' => attribute.title
                                                  }])
    end
  end

  context 'when item has options' do
    it 'includes the choices (and associated options)' do
      choice = create(:room_service_item_choice)
      option1 = choice.options.first
      option2 = choice.options.last

      item.choices << choice

      get "/api/v0/room_service/items/#{item.id}", headers: request_headers

      # noinspection RubyResolve
      expect(response_json).to include('choices' => [{
                                                       'id' => choice.id,
                                                       'title' => choice.title,
                                                       'optional' => choice.optional?,
                                                       'allows_multiple_options' => choice.allows_multiple_options,
                                                       'default_option_id' => choice.default_option_id,
                                                       'options' => [{
                                                                       'id' => option1.id,
                                                                       'title' => option1.title,
                                                                       'price' => option1.price.to_s
                                                                     },
                                                                     {
                                                                       'id' => option2.id,
                                                                       'title' => option2.title,
                                                                       'price' => option2.price.to_s
                                                                     }]
                                                     }])
    end
  end
end