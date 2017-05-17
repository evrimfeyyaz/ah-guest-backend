class Api::V0::RoomService::ItemsController < ActionController::API
  def show
    item = ::RoomService::Item.find(params[:id])

    render json: item, include: [:item_attributes, :possible_options, 'possible_options.possible_choices', 'possible_options.default_choice']
  end
end
