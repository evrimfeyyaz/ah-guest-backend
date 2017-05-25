class Api::V0::UsersController < ActionController::API
  before_action :authorize_client_key

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user, status: :unprocessable_entity, serializer: ErrorSerializer
    end
  end

  private

  def authorize_client_key
    unless request.headers['Authorization'] == Rails.application.secrets.client_key
      head :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end