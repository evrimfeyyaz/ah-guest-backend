class ApiController < ActionController::API
  include Pundit

  attr_reader :property_settings

  before_action :ensure_valid_api_client
  before_action :authenticate_user_by_auth_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :forbidden
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity

  private

  def ensure_valid_api_client
    head :unauthorized if current_api_client.blank?
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

  def current_property
    @current_property ||= Property.find_by(subdomain: request.subdomains.first)
  end

  def current_api_client
    @current_api_client ||= current_property.api_clients.
      find_by(secret: request.headers['ah-client-secret']) unless current_property.blank?
  end

  def not_found
    head :not_found
  end

  def forbidden
    head :forbidden
  end

  def unprocessable_entity
    head :unprocessable_entity
  end

  def no_content
    head :no_content
  end

  def render_validation_error_json(object)
    render json: object, status: :unprocessable_entity, serializer: ValidationErrorSerializer
  end
end