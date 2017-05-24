class Api::V0::AuthenticationsController < ActionController::API
  def create
    email = authentication_params[:email]
    password = authentication_params[:password]

    user = email.present? && User.find_by(email: email)

    if user && user.authenticate(password)
      render json: user
    else
      head :not_found
    end
  end

  private

    def authentication_params
      params.require(:user).permit(:email, :password)
    end
end