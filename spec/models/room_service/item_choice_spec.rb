require 'rails_helper'

describe RoomService::ItemChoice do
  it { should have_many(:options).dependent(:destroy).inverse_of(:choice) }
  it { should have_and_belong_to_many(:items).inverse_of(:choices) }
  it { should belong_to(:default_option) }

  it { should validate_presence_of :title }
end