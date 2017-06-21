require 'rails_helper'

describe 'GET /api/v0/room_service/categories/' do
  it_behaves_like 'an endpoint that requires client secret authentication', :get, '/api/v0/room_service/categories'

  it 'returns all room service categories' do
    category = create(:room_service_category, available_from: 1.hour.ago, available_until: 1.hour.from_now)

    get '/api/v0/room_service/categories/', headers: request_headers

    expect(response.status).to eq(200)
    expect(response_json).to eq([{
                                   'id' => category.id,
                                   'title' => category.title,
                                   'description' => category.description,
                                   'image_urls' => {
                                     '@3x' => nil,
                                     '@2x' => nil,
                                     '@1x' => nil
                                   },
                                   'available_from_utc' => category.available_from.utc.strftime('%H%M'),
                                   'available_until_utc' => category.available_until.utc.strftime('%H%M'),
                                 }])
  end

  context 'when a category has no image' do
    it 'returns nil for image urls' do
      create(:room_service_category)

      get '/api/v0/room_service/categories/', headers: request_headers

      expect(response.status).to eq(200)
      expect(response_json[0]['image_urls']).to eq('@3x' => nil,
                                                   '@2x' => nil,
                                                   '@1x' => nil)
    end
  end

  context 'when a category has images' do
    it 'returns image urls' do
      category_with_image = create(:room_service_category_with_image)

      get '/api/v0/room_service/categories/', headers: request_headers

      expect(response.status).to eq(200)
      expect(response_json[0]['image_urls']).to eq('@3x' => category_with_image.image.url(:three_x),
                                                   '@2x' => category_with_image.image.url(:two_x),
                                                   '@1x' => category_with_image.image.url(:one_x))
    end
  end
end