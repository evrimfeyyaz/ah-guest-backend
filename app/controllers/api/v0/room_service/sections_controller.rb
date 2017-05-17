class Api::V0::RoomService::SectionsController < ActionController::API
  def index
    if params[:category_id]
      sections = ::RoomService::Section.where(category: params[:category_id]).where('room_service_items_count > 0')

      if sections.empty?
        head :no_content
      else
        render json: sections, include: :items
      end
    end
  end
end
