require 'rails_helper'

describe 'GET /api/v0/room_service/categories/:category_id/sub_categories' do
  it_behaves_like 'an endpoint that requires client secret authentication', :get, '/api/v0/room_service/categories/0/sub_categories'

  let!(:category) { create(:room_service_category) }

  it 'returns all sub-categories and item summaries' do
    sub_category = category.default_sub_category

    item = sub_category.items.create(attributes_for(:room_service_item))

    get "/api/v0/room_service/categories/#{category.id}/sub_categories/", headers: request_headers

    expect(response.status).to eq(200)
    expect(response_json).to eq([
                                  {
                                    'id' => sub_category.id,
                                    'title' => sub_category.title,
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

  context 'when a sub-category has no items' do
    it 'does not return that sub-category' do
      sub_category_with_item = category.sub_categories.create(attributes_for(:room_service_sub_category))
      item = sub_category_with_item.items.create(attributes_for(:room_service_item))

      get "/api/v0/room_service/categories/#{category.id}/sub_categories/", headers: request_headers

      expect(response.status).to eq(200)
      expect(response_json).to eq([{
                                     'id' => sub_category_with_item.id,
                                     'title' => sub_category_with_item.title,
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

  context 'when there is no sub-category with items' do
    it 'responds with "204 No Content"' do
      get "/api/v0/room_service/categories/#{category.id}/sub_categories/", headers: request_headers

      expect(response.status).to eq(204)
    end
  end
end