class Api::V0::AuthenticationsController < ActionController::API
  def create
    email = credential_params[:email]
    password = credential_params[:password]

    user = email.present? && User.find_by(email: email)

    if user && user.authenticate(password)
      render json: user
    else
      head :not_found
    end
  end

  private

    def credential_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:email, :password])
    end
end