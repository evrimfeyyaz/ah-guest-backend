class Api::V0::RoomService::SectionsController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:index]

  def index
    if params[:category_id]
      sections = ::RoomService::SubCategory.where(category: params[:category_id]).where('room_service_items_count > 0')

      if sections.empty?
        head :no_content
      else
        render json: sections, include: :items
      end
    end
  end
end
