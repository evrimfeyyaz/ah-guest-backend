class ApiController < ActionController::API
  before_action :authorize_client_by_client_secret
  before_action :authenticate_user_by_auth_token

  private

  def authorize_client_by_client_secret
    unless request.headers['ah-client-secret'] == Rails.application.secrets.client_secret
      head :unauthorized
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