class V0::RoomService::ItemsController < ApplicationController
  def show
    item = ::RoomService::Item.find(params[:id])

    render json: item
  end
end
