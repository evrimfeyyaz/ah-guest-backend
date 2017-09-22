class Api::V0::AuthorizationErrorSerializer < Api::V0::ErrorSerializer
  def error_type
    'authorization'
  end

  def errors
    object
  end
end