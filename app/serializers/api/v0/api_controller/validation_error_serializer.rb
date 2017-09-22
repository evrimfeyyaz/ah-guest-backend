class Api::V0::ApiController::ValidationErrorSerializer < Api::V0::ErrorSerializer
  def error_type
    :validation
  end
end