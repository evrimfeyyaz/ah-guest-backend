class Api::V0::ApiController::UserAuthenticationErrorSerializer < Api::V0::ErrorSerializer
  def error_type
    :user_authentication
  end
end