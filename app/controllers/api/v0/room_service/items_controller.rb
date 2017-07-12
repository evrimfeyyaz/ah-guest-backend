class Api::V0::RoomService::ItemsController < ApiController
  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_not_found

  skip_before_action :authenticate_user_by_auth_token, only: [:show]

  def show
    item = ::RoomService::Item.find(params[:id])

    render json: item, include: ['tags', 'choices', 'choices.options']
  end

  private

    def respond_with_not_found
      head :not_found
    end
end
