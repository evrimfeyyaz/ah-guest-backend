class ClientAuthenticationErrorSerializer < ErrorSerializer
  def error_type
    :client_authentication
  end
end