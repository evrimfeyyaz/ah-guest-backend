module JSONHelpers
  def response_json
    JSON.parse(response.body) unless response.body.blank?
  end

  def json_headers
    { 'CONTENT_TYPE' => 'application/json' }
  end
end

RSpec.configure do |config|
  config.include JSONHelpers
end