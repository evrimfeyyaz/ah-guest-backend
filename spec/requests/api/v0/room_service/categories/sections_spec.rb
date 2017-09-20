require 'rails_helper'

describe 'GET /api/v0/room_service/categories/:category_id/sections' do
  it_behaves_like 'an endpoint that requires client secret authentication', :get, '/api/v0/room_service/categories/0/sections'

  context 'when there is at least one section with items' do
    let(:category) { create(:room_service_category_with_items_in_default_section, items_count: 1) }
    let(:section) { category.default_section }
    let(:item) { section.items.first }

    it 'returns all sections and item summaries (200)' do
      get "/api/v0/room_service/categories/#{category.id}/sections/", headers: request_headers

      expect(response.status).to eq(200)
      expect(response_json).to eq([
                                    {
                                      'id' => section.id,
                                      'title' => section.title,
                                      'items' => [
                                        {
                                          'id' => item.id,
                                          'title' => item.title,
                                          'price' => item.price.to_s,
                                          'short_description' => item.short_description,
                                          'description' => item.description
                                        }
                                      ]
                                    }
                                  ])
    end

    it 'does not return empty sections' do
      empty_section = create(:room_service_category_section, items: [])
      category.sections << empty_section

      get "/api/v0/room_service/categories/#{category.id}/sections/", headers: request_headers

      expect(response_json).to eq([{
                                     'id' => section.id,
                                     'title' => section.title,
                                     'items' => [{
                                                   'id' => item.id,
                                                   'title' => item.title,
                                                   'price' => item.price.to_s,
                                                   'short_description' => item.short_description,
                                                   'description' => item.description
                                                 }]
                                   }])
    end
  end

  context 'when there is no section with items' do
    it 'responds with no content (204)' do
      category = create(:room_service_category)

      get "/api/v0/room_service/categories/#{category.id}/sections/", headers: request_headers

      expect(response.status).to eq(204)
    end
  end
end