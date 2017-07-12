class AuthorizationErrorSerializer < ErrorSerializer
  def error_type
    'authorization'
  end

  def errors
    object
  end
end