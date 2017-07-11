class UserAuthenticationErrorSerializer < ErrorSerializer
  def error_type
    :user_authentication
  end
end