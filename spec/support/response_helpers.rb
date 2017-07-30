module ResponseHelpers
  def response_json
    JSON.parse(response.body) unless response.body.blank?
  end

  def response_error
    response_json['error_type']
  end
end

RSpec.configure do |config|
  config.include ResponseHelpers
end