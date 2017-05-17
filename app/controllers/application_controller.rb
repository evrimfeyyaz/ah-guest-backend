class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # http://stackoverflow.com/a/22715175
  skip_before_action :verify_authenticity_token, if: :json_request?

  def json_request?
    request.format.json?
  end
end
