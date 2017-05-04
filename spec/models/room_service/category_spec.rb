require 'rails_helper'

describe RoomService::Category, 'Validations' do
  it { should validate_presence_of :title }
end
