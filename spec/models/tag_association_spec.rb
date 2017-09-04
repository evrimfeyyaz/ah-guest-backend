require 'rails_helper'

describe RoomService::Item::TagAssociation do
  it { should belong_to(:item) }
  it { should belong_to(:tag) }
end
