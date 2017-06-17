class Api::V0::RoomService::SubCategoriesController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:index]

  def index
    if params[:category_id]
      sub_categories = ::RoomService::SubCategory.where(category: params[:category_id]).where('room_service_items_count > 0')

      if sub_categories.empty?
        head :no_content
      else
        render json: sub_categories, include: :items
      end
    end
  end
end
