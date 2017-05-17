class Api::V0::UsersController < ActionController::API
  # protect_from_forgery with: :null_session

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

    def user_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:email, :password, 'password-confirmation', 'first-name', 'last-name'])
    end
end