class Api::V0::ClientAuthenticationErrorSerializer < Api::V0::ErrorSerializer
  def error_type
    :client_authentication
  end
end