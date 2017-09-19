require 'rails_helper'

describe ApiClient do
  it { should belong_to(:property).inverse_of(:api_clients) }
end
