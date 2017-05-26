class ApiController < ActionController::API
  before_action :authorize_client_by_client_secret
  before_action :authenticate_user_by_auth_token

  private

  def authorize_client_by_client_secret
    unless request.headers['ah-client-secret'] == Rails.application.secrets.client_secret
      head :unauthorized
    end
  end

  def authenticate_user_by_auth_token
    user_id = request.headers['ah-user-id']
    auth_token = request.headers['Authorization']

    begin
      user = User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      head :unauthorized
    end

    unless user && auth_token && ActiveSupport::SecurityUtils.secure_compare(user.auth_token, auth_token)
      head :unauthorized
    end
  end
end