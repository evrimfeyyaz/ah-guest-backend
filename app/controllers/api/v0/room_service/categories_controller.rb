class Api::V0::RoomService::CategoriesController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:index]

  def index
    load_categories
    render_categories_json
  end

  private

  def load_categories
    @categories ||= category_scope.to_a
  end

  def render_categories_json
    render json: @categories
  end

  def category_scope
    policy_scope(RoomService::Category)
  end
end