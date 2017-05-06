require 'rails_helper'

describe 'GET /v0/room-service/categories/' do
  it 'returns all room service categories' do
    category1 = create(:room_service_category)
    category2 = create(:room_service_category)

    get '/v0/room-service/categories/'

    expect(response_json).to eq('data' => [
                                 {
                                   'id' => category1.id.to_s,
                                   'type' => 'room-service-categories',
                                   'attributes' =>
                                     {
                                       'title' => category1.title,
                                       'description' => category1.description,
                                       'images' => {
                                         '@3x' => category1.image.url(:three_x),
                                         '@2x' => category1.image.url(:two_x),
                                         '@1x' => category1.image.url(:one_x)
                                       }
                                     }
                                 },
                                 {
                                   'id' => category2.id.to_s,
                                   'type' => 'room-service-categories',
                                   'attributes' => {
                                     'title' => category2.title,
                                     'description' => category2.description,
                                     'images' => {
                                       '@3x' => category2.image.url(:three_x),
                                       '@2x' => category2.image.url(:two_x),
                                       '@1x' => category2.image.url(:one_x)
                                     }
                                   }
                                 }
                               ]
                             )
  end
end