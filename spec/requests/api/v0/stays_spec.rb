require 'rails_helper'

describe 'POST /api/v0/users/:user_id/stays' do
  it_behaves_like 'an endpoint that requires client secret authorization', :post, '/api/v0/users/:user_id/stays'


end