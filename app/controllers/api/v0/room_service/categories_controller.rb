class Api::V0::RoomService::CategoriesController < ApiController
  def index
    categories = ::RoomService::Category.all

    render json: categories
  end
end