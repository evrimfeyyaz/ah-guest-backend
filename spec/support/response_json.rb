module ResponseJSON
  def response_json
    JSON.parse(response.body) unless response.body.blank?
  end
end

RSpec.configure do |config|
  config.include ResponseJSON
end