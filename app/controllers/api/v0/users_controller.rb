class Api::V0::UsersController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:create]

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user, status: :unprocessable_entity, serializer: ValidationErrorSerializer
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end