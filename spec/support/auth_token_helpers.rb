module AuthTokenWithIDHelpers
  def token_with_id_replaced(auth_token_with_id, new_id)
    auth_token = get_auth_token(auth_token_with_id)

    "#{new_id}.#{auth_token}"
  end

  def token_with_auth_section_replaced(auth_token_with_id, new_auth_token)
    id = get_id(auth_token_with_id)

    "#{id}.#{new_auth_token}"
  end

  def get_id(auth_token_with_id)
    auth_token_with_id.partition('.')[0]
  end

  def get_auth_token(auth_token_with_id)
    auth_token_with_id.partition('.')[2]
  end
end

RSpec.configure do |config|
  config.include AuthTokenWithIDHelpers
end