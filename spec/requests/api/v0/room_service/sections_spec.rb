require 'rails_helper'

describe 'GET /api/v0/room_service/categories/:category_id/sections' do
  it_behaves_like 'an endpoint that requires client secret authentication', :get, '/api/v0/room_service/categories/0/sections'

  let!(:category) { create(:room_service_category) }

  it 'returns all sections and item summaries' do
    section = category.default_section

    item = section.items.create(attributes_for(:room_service_item))

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

  context 'when a section has no items' do
    it 'does not return that section' do
      section_with_item = category.sections.create(attributes_for(:room_service_category_section))
      item = section_with_item.items.create(attributes_for(:room_service_item))

      get "/api/v0/room_service/categories/#{category.id}/sections/", headers: request_headers

      expect(response.status).to eq(200)
      expect(response_json).to eq([{
                                     'id' => section_with_item.id,
                                     'title' => section_with_item.title,
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
    it 'responds with "204 No Content"' do
      get "/api/v0/room_service/categories/#{category.id}/sections/", headers: request_headers

      expect(response.status).to eq(204)
    end
  end
end