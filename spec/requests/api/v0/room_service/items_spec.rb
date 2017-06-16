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
                                    'long_description' => item.long_description,
                                    'price' => item.price.to_s,
                                    'tags' => [],
                                    'options' => []
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
    it 'includes the options (and associated choices)' do
      option = create(:room_service_item_choice_with_multiple_options, choices_count: 2)
      choice1 = option.possible_choices.first
      choice2 = option.possible_choices.last

      item.options << option

      get "/api/v0/room_service/items/#{item.id}", headers: request_headers

      # noinspection RubyResolve
      expect(response_json).to include('options' => [{
                                                       'id' => option.id,
                                                       'title' => option.title,
                                                       'optional' => option.optional?,
                                                       'allows_multiple_choices' => option.allows_multiple_choices,
                                                       'default_room_service_choice_id' => option.default_room_service_choice_id,
                                                       'possible_choices' => [{
                                                                                'id' => choice1.id,
                                                                                'title' => choice1.title,
                                                                                'price' => choice1.price.to_s
                                                                              },
                                                                              {
                                                                                'id' => choice2.id,
                                                                                'title' => choice2.title,
                                                                                'price' => choice2.price.to_s
                                                                              }]
                                                     }])
    end
  end
end