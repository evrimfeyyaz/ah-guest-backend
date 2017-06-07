class ApiController < ActionController::API
  before_action :authenticate_client_by_client_secret
  before_action :authenticate_user_by_auth_token

  private

  def authenticate_client_by_client_secret
    client_authenticator = ClientAuthenticator.new(request.headers['ah-client-secret'])

    unless client_authenticator.authenticate
      render json: client_authenticator, status: :unauthorized,
             serializer: ClientAuthenticationErrorSerializer
    end
  end

  def current_user
    @current_user ||= User.find_by(id: request.headers['ah-user-id'])
  end

  def authenticate_user_by_auth_token
    auth_token = request.headers['Authorization']

    unless current_user && auth_token && ActiveSupport::SecurityUtils.secure_compare(current_user.auth_token, auth_token)
      head :unauthorized
    end
  end
end