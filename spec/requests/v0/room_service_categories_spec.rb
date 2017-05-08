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
                                  ])
  end

  it 'returns nil when an image is missing' do
    create(:room_service_category)

    get '/v0/room-service/categories/'

    expect(response_json['data'][0]['attributes']['image-urls']).to eq('@3x' => nil,
                                                                       '@2x' => nil,
                                                                       '@1x' => nil)
  end
end

describe 'GET /v0/room-service/categories/:category_id/sections' do
  let!(:category) { create(:room_service_category) }

  it 'returns all sections and item summaries' do
    section1 = category.default_section
    section2 = category.sections.create(attributes_for(:room_service_section))

    item1 = section1.items.create(attributes_for(:room_service_item))
    item2 = section1.items.create(attributes_for(:room_service_item))
    item3 = section2.items.create(attributes_for(:room_service_item))

    get "/v0/room-service/categories/#{category.id}/sections/"

    expect(response_json).to eq('data' =>
                                  [
                                    {
                                      'id' => section1.id.to_s,
                                      'type' => 'room-service-sections',
                                      'attributes' => {
                                        'title' => section1.title,
                                        'default' => section1.default
                                      },
                                      'relationships' => {
                                        'items' => {
                                          'data' => [
                                            {
                                              'type' => 'room-service-items',
                                              'id' => item1.id.to_s
                                            },
                                            {
                                              'type' => 'room-service-items',
                                              'id' => item2.id.to_s
                                            }
                                          ]
                                        }
                                      }
                                    },
                                    {
                                      'id' => section2.id.to_s,
                                      'type' => 'room-service-sections',
                                      'attributes' => {
                                        'title' => section2.title,
                                        'default' => section2.default
                                      },
                                      'relationships' => {
                                        'items' => {
                                          'data' => [
                                            {
                                              'type' => 'room-service-items',
                                              'id' => item3.id.to_s
                                            }
                                          ]
                                        }
                                      }
                                    }
                                  ],
                                'included' =>
                                  [
                                    {
                                      'type' => 'room-service-items',
                                      'id' => item1.id.to_s,
                                      'attributes' => {
                                        'title' => item1.title,
                                        'short-description' => item1.short_description,
                                        'price' => item1.price.to_s
                                      }
                                    },
                                    {
                                      'type' => 'room-service-items',
                                      'id' => item2.id.to_s,
                                      'attributes' => {
                                        'title' => item2.title,
                                        'short-description' => item2.short_description,
                                        'price' => item2.price.to_s
                                      }
                                    },
                                    {
                                      'type' => 'room-service-items',
                                      'id' => item3.id.to_s,
                                      'attributes' => {
                                        'title' => item3.title,
                                        'short-description' => item3.short_description,
                                        'price' => item3.price.to_s
                                      }
                                    }
                                  ])
  end

  it 'does not return a section if it has no items' do
    section = category.sections.create(attributes_for(:room_service_section))
    item = section.items.create(attributes_for(:room_service_item))

    get "/v0/room-service/categories/#{category.id}/sections/"

    expect(response_json).to eq('data' =>
                                  [
                                    {
                                      'id' => section.id.to_s,
                                      'type' => 'room-service-sections',
                                      'attributes' => {
                                        'title' => section.title,
                                        'default' => section.default
                                      },
                                      'relationships' => {
                                        'items' => {
                                          'data' => [
                                            {
                                              'type' => 'room-service-items',
                                              'id' => item.id.to_s
                                            }
                                          ]
                                        }
                                      }
                                    }
                                  ],
                                'included' =>
                                  [
                                    {
                                      'type' => 'room-service-items',
                                      'id' => item.id.to_s,
                                      'attributes' => {
                                        'title' => item.title,
                                        'short-description' => item.short_description,
                                        'price' => item.price.to_s
                                      }
                                    }
                                  ]
                             )
  end
end