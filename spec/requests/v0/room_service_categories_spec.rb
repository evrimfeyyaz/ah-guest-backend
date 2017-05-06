require 'rails_helper'

describe 'GET /v0/room-service/categories/' do
  it 'returns all room service categories' do
    category1 = create(:room_service_category)
    category2 = create(:room_service_category)

    get '/v0/room-service/categories/'

    expect(response_json).to eq('data' =>
                                  [
                                    {
                                      'id' => category1.id.to_s,
                                      'type' => 'room-service-categories',
                                      'attributes' => {
                                        'title' => category1.title,
                                        'description' => category1.description,
                                        'image-urls' => {
                                          '@3x' => category1.image_urls['@3x'],
                                          '@2x' => category1.image_urls['@2x'],
                                          '@1x' => category1.image_urls['@1x']
                                        }
                                      }
                                    },
                                    {
                                      'id' => category2.id.to_s,
                                      'type' => 'room-service-categories',
                                      'attributes' => {
                                        'title' => category2.title,
                                        'description' => category2.description,
                                        'image-urls' => {
                                          '@3x' => category2.image_urls['@3x'],
                                          '@2x' => category2.image_urls['@2x'],
                                          '@1x' => category2.image_urls['@1x']
                                        }
                                      }
                                    }
                                  ]
                             )
  end

  it 'returns nil when an image is missing' do
    create(:room_service_category)

    get '/v0/room-service/categories/'

    expect(response_json['data'][0]['attributes']['image-urls']).to eq(
                                                                      '@3x' => nil,
                                                                      '@2x' => nil,
                                                                      '@1x' => nil
                                                                    )
  end
end