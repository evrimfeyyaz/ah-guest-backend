require 'rails_helper'

describe RoomService::Section, 'Validations' do
  it { should validate_presence_of :title }
  it { should belong_to :category }
end

describe RoomService::Section, 'Default section' do

end
