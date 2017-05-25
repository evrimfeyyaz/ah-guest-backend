require 'rails_helper'

describe 'GET /api/v0/room-service/categories/' do
  it 'returns all room service categories' do
    category = create(:room_service_category)

    get '/api/v0/room-service/categories/'

    expect(response.status).to eq(200)
    expect(response_json).to eq([{
                                   'id' => category.id,
                                   'title' => category.title,
                                   'description' => category.description,
                                   'image_urls' => {
                                     '@3x' => nil,
                                     '@2x' => nil,
                                     '@1x' => nil
                                   }
                                 }])
  end

  context 'when a category has no image' do
    it 'returns nil for image urls' do
      create(:room_service_category)

      get '/api/v0/room-service/categories/'

      expect(response.status).to eq(200)
      expect(response_json[0]['image_urls']).to eq('@3x' => nil,
                                                   '@2x' => nil,
                                                   '@1x' => nil)
    end
  end

  context 'when a category has images' do
    it 'returns image urls' do
      category_with_image = create(:room_service_category_with_image)

      get '/api/v0/room-service/categories/'

      expect(response.status).to eq(200)
      expect(response_json[0]['image_urls']).to eq('@3x' => category_with_image.image.url(:three_x),
                                                   '@2x' => category_with_image.image.url(:two_x),
                                                   '@1x' => category_with_image.image.url(:one_x))
    end
  end
end

describe 'GET /api/v0/room-service/categories/:category_id/sections' do
  let!(:category) { create(:room_service_category) }

  it 'returns all sections and item summaries' do
    section = category.default_section

    item = section.items.create(attributes_for(:room_service_item))

    get "/api/v0/room-service/categories/#{category.id}/sections/"

    expect(response.status).to eq(200)
    expect(response_json).to eq([{
                                   'id' => section.id,
                                   'title' => section.title,
                                   'items' => [{
                                                 'id' => item.id,
                                                 'title' => item.title,
                                                 'price' => item.price.to_s,
                                                 'short_description' => item.short_description
                                               }]
                                 }])
  end

  context 'when a section has no items' do
    it 'does not return that section' do
      section_with_item = category.sections.create(attributes_for(:room_service_section))
      item = section_with_item.items.create(attributes_for(:room_service_item))

      get "/api/v0/room-service/categories/#{category.id}/sections/"

      expect(response.status).to eq(200)
      expect(response_json).to eq([{
                                     'id' => section_with_item.id,
                                     'title' => section_with_item.title,
                                     'items' => [{
                                                   'id' => item.id,
                                                   'title' => item.title,
                                                   'price' => item.price.to_s,
                                                   'short_description' => item.short_description
                                                 }]
                                   }])
    end
  end

  context 'when there is no section with items' do
    it 'responds with "204 No Content"' do
      get "/api/v0/room-service/categories/#{category.id}/sections/"

      expect(response.status).to eq(204)
    end
  end
end