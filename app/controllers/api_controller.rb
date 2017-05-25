class ApiController < ActionController::API
  before_action :authorize_client_by_client_key

  private

  def authorize_client_by_client_key
    unless request.headers['ah-client-secret'] == Rails.application.secrets.client_secret
      head :unauthorized
    end
  end
end
