require 'rails_helper'

describe RoomService::Tag do
  it { should have_and_belong_to_many(:items).inverse_of(:tags) }

  it { should validate_presence_of :title }
end
