class Api::V0::RoomService::CategoriesController < ActionController::API
  def index
    categories = ::RoomService::Category.all

    render json: categories
  end
end