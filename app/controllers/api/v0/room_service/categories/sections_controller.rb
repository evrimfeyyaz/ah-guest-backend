class Api::V0::RoomService::Categories::SectionsController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:index]

  def index
    load_category_sections
    render_category_sections or no_content
  end

  private

  def load_category_sections
    @category_section ||= category_section_scope.to_a
  end

  def render_category_sections
    render json: @category_section, include: :items if @category_section.any?
  end

  def category_section_scope
    ::RoomService::Category::Section
      .where(room_service_category_id: params[:category_id])
      .where('room_service_items_count > 0')
  end
end