module RequestHeaders
  def request_headers(options = {})
    client_secret = options.key?(:client_secret) ? options[:client_secret] : @property.api_clients.take.secret

    headers = {
      'ah-client-secret' => client_secret,
      'Content-Type' => 'application/json'
    }

    if options.key?(:auth_token)
      headers.merge!('Authorization' => options[:auth_token])
    end

    if options.key?(:user_id)
      headers.merge!('ah-user-id' => options[:user_id])
    end

    if options.key?(:user)
      headers.merge!({ 'ah-user-id' => options[:user].id,
                       'Authorization' => options[:user].auth_token })
    end

    headers
  end
end

RSpec.configure do |config|
  config.include RequestHeaders
end