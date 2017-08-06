class ApiController < ActionController::API
  include Pundit

  before_action :authenticate_client_by_client_secret
  before_action :authenticate_user_by_auth_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :forbidden
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity

  private

  def authenticate_client_by_client_secret
    client_authenticator = ClientAuthenticator.new(request.headers['ah-client-secret'])

    unless client_authenticator.authenticate
      render json: client_authenticator, status: :unauthorized,
             serializer: ClientAuthenticationErrorSerializer
    end
  end

  def current_user
    user_id = request.headers['ah-user-id']

    @current_user ||= User.find(user_id) unless user_id.blank?
  end

  def authenticate_user_by_auth_token
    user_authenticator = UserAuthenticator.new(request.headers['ah-user-id'], request.headers['Authorization'])

    unless user_authenticator.authenticate
      render json: user_authenticator, status: :unauthorized,
             serializer: UserAuthenticationErrorSerializer
    end
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