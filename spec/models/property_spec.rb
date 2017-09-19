require 'rails_helper'

describe Property do
  it { should have_many(:api_clients).inverse_of(:property).dependent(:destroy) }
end
