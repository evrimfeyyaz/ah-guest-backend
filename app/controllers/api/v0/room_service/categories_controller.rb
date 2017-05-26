class Api::V0::RoomService::CategoriesController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:index]

  def index
    categories = ::RoomService::Category.all

    render json: categories
  end
end