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
    user_authenticator = UserAuthenticator.new(request.headers['ah-user-id'], request.headers['Authorization'])

    unless user_authenticator.authenticate
      render json: user_authenticator, status: :unauthorized,
             serializer: UserAuthenticationErrorSerializer
    end
  end
end