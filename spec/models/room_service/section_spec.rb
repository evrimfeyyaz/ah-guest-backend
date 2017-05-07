require 'rails_helper'

describe RoomService::Section, 'Validations' do
  it { should validate_presence_of :title }
end
