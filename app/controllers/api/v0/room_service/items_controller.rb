class Api::V0::RoomService::ItemsController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:show]

  def show
    load_item
    render_item_json
  end

  private

  def load_item
    @item ||= item_scope.find(params[:id])
  end

  def render_item_json
    render json: @item, include: %w(tags choices choices.options)
  end

  def item_scope
    policy_scope(RoomService::Item)
  end
end
