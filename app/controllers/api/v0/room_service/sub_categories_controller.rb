class Api::V0::RoomService::SubCategoriesController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:index]

  def index
    load_sub_categories
    render_sub_categories or no_content
  end

  private

  def load_sub_categories
    @sub_categories ||= sub_category_scope.to_a
  end

  def render_sub_categories
    render json: @sub_categories, include: :items if @sub_categories.any?
  end

  def sub_category_scope
    policy_scope(RoomService::SubCategory)
      .where(room_service_category_id: params[:category_id])
      .where('room_service_items_count > 0')
  end
end