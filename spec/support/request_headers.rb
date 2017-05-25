module RequestHeaders
  def headers(options = {})
    client_secret = options.key?(:client_secret) ? options[:client_secret] : Rails.application.secrets.client_secret
    auth_token = options.key?(:auth_token) ? options[:auth_token] : nil

    {
      'ah-client-secret' => client_secret,
      'Authorization' => auth_token,
      'Content-Type' => 'application/json'
    }
  end
end

RSpec.configure do |config|
  config.include RequestHeaders
end