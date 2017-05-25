module RequestHeaders
  def headers(auth_token = nil)
    {
      'Authorization' => auth_token,
      'Content-Type' => 'application/json'
    }
  end
end

RSpec.configure do |config|
  config.include RequestHeaders
end