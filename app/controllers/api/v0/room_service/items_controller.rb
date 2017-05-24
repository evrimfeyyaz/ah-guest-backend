class Api::V0::RoomService::ItemsController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_not_found

  def show
    item = ::RoomService::Item.find(params[:id])

    render json: item, include: [:item_attributes, :options, 'options.possible_choices']
  end

  private

    def respond_with_not_found
      head :not_found
    end
end
