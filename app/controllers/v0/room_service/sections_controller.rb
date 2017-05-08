class V0::RoomService::SectionsController < ApplicationController
  def index
    if params[:category_id]
      @sections = ::RoomService::Section.where(category: params[:category_id]).where('room_service_items_count > 0')

      render json: @sections, include: :items
    end
  end
end
