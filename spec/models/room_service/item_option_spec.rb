require 'rails_helper'

describe RoomService::ItemOption, 'Validations' do
  it { should validate_presence_of :title }
  it { should have_many :possible_choices }
end

describe RoomService::ItemOption, 'Choices' do
  let!(:item_option) { create(:room_service_item_option_with_choices) }

  it 'destroys dependent choices upon destroy' do
    expect {
      item_option.destroy
    }.to change(RoomService::ItemOptionChoice, :count).by(-2)
  end
end
