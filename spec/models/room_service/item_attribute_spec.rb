require 'rails_helper'

describe RoomService::Section, 'Validations' do
  it { should validate_presence_of :title }
  # TODO: Check if you can change the table name to the one that is recommended when you run the following test.
  # it { should have_and_belong_to_many :items }
end
