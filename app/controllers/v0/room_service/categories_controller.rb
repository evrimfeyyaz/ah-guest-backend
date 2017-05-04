class V0::RoomService::CategoriesController < ApplicationController
  def index
    @categories = ::RoomService::Category.all

    render json: @categories
  end
end
