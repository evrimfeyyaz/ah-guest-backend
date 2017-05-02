require 'rails_helper'

describe 'GET /v0/room-service/categories/' do

  it 'returns all room service categories' do
    rs_categories = RSCategories.all

    get '/v0/room-service/categories/'

    expect
  end
end