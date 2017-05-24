class Api::V0::UsersController < ActionController::API
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user, status: :unprocessable_entity, serializer: ErrorSerializer
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end