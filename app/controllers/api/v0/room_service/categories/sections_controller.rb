class Api::V0::RoomService::Categories::SectionsController < Api::V0::ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:index]

  def index
    load_sections
    render_sections or no_content
  end

  private

  def load_sections
    @sections ||= section_scope.to_a
  end

  def render_sections
    render json: @sections, include: :items if @sections.any?
  end

  def section_scope
    ::RoomService::Category::Section
      .where(room_service_category_id: params[:category_id])
      .where('room_service_items_count > 0')
  end
end