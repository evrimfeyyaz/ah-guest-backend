require 'rails_helper'

describe Stay do
  it { should belong_to(:user).inverse_of(:stays) }
  it { should have_many(:room_service_orders).inverse_of(:stay).class_name('RoomService::Order') }
end
