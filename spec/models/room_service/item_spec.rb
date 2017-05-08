require 'rails_helper'

describe RoomService::Item, 'Validations' do
  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end
